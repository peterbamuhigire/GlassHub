import Foundation

protocol LocalRepositoryScanning: Sendable {
    func discoverRepositories() async throws -> [Repository]
}

struct LocalRepositoryScanner: LocalRepositoryScanning {
    func discoverRepositories() async throws -> [Repository] {
        await Task.detached(priority: .utility) {
            Self.scanCommonLocations()
        }.value
    }

    private static func scanCommonLocations() -> [Repository] {
        let fileManager = FileManager.default
        let home = fileManager.homeDirectoryForCurrentUser
        let candidateRoots = [
            home,
            home.appending(path: "Developer"),
            home.appending(path: "Projects"),
            home.appending(path: "Sites"),
            home.appending(path: "Documents"),
            home.appending(path: "Desktop")
        ]

        var repositories: [Repository] = []
        var seenPaths = Set<String>()

        for root in candidateRoots where fileManager.fileExists(atPath: root.path) {
            guard let enumerator = fileManager.enumerator(
                at: root,
                includingPropertiesForKeys: [.isDirectoryKey, .isHiddenKey],
                options: [.skipsPackageDescendants, .skipsHiddenFiles]
            ) else {
                continue
            }

            for case let url as URL in enumerator {
                guard url.lastPathComponent == ".git" else { continue }
                let repoURL = url.deletingLastPathComponent()
                guard seenPaths.insert(repoURL.path).inserted else { continue }

                repositories.append(
                    Repository(
                        name: repoURL.lastPathComponent,
                        owner: repoURL.deletingLastPathComponent().lastPathComponent,
                        path: repoURL.path,
                        currentBranch: currentBranch(for: url) ?? "main",
                        syncStatus: .offline,
                        languageBreakdown: [],
                        commits: [],
                        changedFiles: [],
                        branches: [],
                        pullRequests: [],
                        weeklyActivity: []
                    )
                )

                enumerator.skipDescendants()
                if repositories.count >= 40 { break }
            }
        }

        return repositories.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
    }

    private static func currentBranch(for gitDirectory: URL) -> String? {
        let head = gitDirectory.appending(path: "HEAD")
        guard let contents = try? String(contentsOf: head, encoding: .utf8) else { return nil }
        let trimmed = contents.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmed.hasPrefix("ref: refs/heads/") else {
            return String(trimmed.prefix(7))
        }
        return String(trimmed.dropFirst("ref: refs/heads/".count))
    }
}
