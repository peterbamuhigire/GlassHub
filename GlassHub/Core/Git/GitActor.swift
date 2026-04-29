import Foundation

actor GitActor {
    func status(for repository: Repository) async -> [ChangedFile] {
        repository.changedFiles
    }

    func recentCommits(for repository: Repository, limit: Int = 200) async -> [Commit] {
        Array(repository.commits.prefix(limit))
    }
}
