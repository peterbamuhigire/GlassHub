import Foundation
import Observation

@Observable
final class AppState {
    var repositoryGroups: [RepositoryGroup]
    var selectedRepositoryID: Repository.ID?
    var selectedCommitID: Commit.ID?
    var selectedWorkspaceTab: WorkspaceTab = .commits
    var isCommandPalettePresented = false
    var isDiscoveringRepositories = false
    var searchText = ""
    var accounts: [GitHubAccount]

    private let scanner: LocalRepositoryScanning

    init(
        repositoryGroups: [RepositoryGroup] = SampleData.repositoryGroups,
        accounts: [GitHubAccount] = SampleData.accounts,
        scanner: LocalRepositoryScanning = LocalRepositoryScanner()
    ) {
        self.repositoryGroups = repositoryGroups
        self.accounts = accounts
        self.scanner = scanner
        self.selectedRepositoryID = repositoryGroups.flatMap(\.repositories).first?.id
        self.selectedCommitID = repositoryGroups.flatMap(\.repositories).first?.commits.first?.id
    }

    var allRepositories: [Repository] {
        repositoryGroups.flatMap(\.repositories)
    }

    var filteredGroups: [RepositoryGroup] {
        guard !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return repositoryGroups
        }

        return repositoryGroups.compactMap { group in
            let repos = group.repositories.filter {
                FuzzyIndex.matches(needle: searchText, haystack: $0.name)
                    || FuzzyIndex.matches(needle: searchText, haystack: $0.path)
                    || FuzzyIndex.matches(needle: searchText, haystack: $0.currentBranch)
            }
            return repos.isEmpty ? nil : RepositoryGroup(name: group.name, repositories: repos)
        }
    }

    var selectedRepository: Repository? {
        guard let selectedRepositoryID else { return nil }
        return allRepositories.first { $0.id == selectedRepositoryID }
    }

    var selectedCommit: Commit? {
        guard let selectedCommitID, let selectedRepository else { return nil }
        return selectedRepository.commits.first { $0.id == selectedCommitID }
    }

    func select(_ repository: Repository) {
        selectedRepositoryID = repository.id
        selectedCommitID = repository.commits.first?.id
        selectedWorkspaceTab = .commits
    }

    func select(_ commit: Commit) {
        selectedCommitID = commit.id
    }

    func bootstrap() async {
        guard !isDiscoveringRepositories else { return }
        isDiscoveringRepositories = true
        defer { isDiscoveringRepositories = false }

        do {
            let discovered = try await scanner.discoverRepositories()
            guard !discovered.isEmpty else { return }

            let existingPaths = Set(allRepositories.map(\.path))
            let newRepos = discovered.filter { !existingPaths.contains($0.path) }
            guard !newRepos.isEmpty else { return }

            if let index = repositoryGroups.firstIndex(where: { $0.name == "Discovered" }) {
                repositoryGroups[index].repositories.append(contentsOf: newRepos)
            } else {
                repositoryGroups.append(RepositoryGroup(name: "Discovered", repositories: newRepos))
            }

            if selectedRepositoryID == nil {
                selectedRepositoryID = newRepos.first?.id
            }
        } catch {
            // A failed scan should not block the starter app from opening.
        }
    }

    static let preview = AppState()
}
