import Foundation
import SwiftData

/// Background actor that owns its own `ModelContext` for off-main writes.
///
/// `ModelContext` is not `Sendable`, so each actor instance must be the sole owner
/// of its context. Hand work to the actor via the `perform` entry point and let the
/// closure mutate the context inside the actor's isolation domain.
@ModelActor
actor PersistenceActor {
    /// Run a unit of work against this actor's context, then save.
    @discardableResult
    func perform<T>(_ work: (ModelContext) throws -> T) throws -> T {
        let result = try work(modelContext)
        if modelContext.hasChanges {
            try modelContext.save()
        }
        return result
    }

    /// Insert or update a stored repository keyed by `path`.
    func upsertRepository(
        path: String,
        name: String,
        owner: String,
        currentBranch: String,
        syncStatusRaw: String
    ) throws -> PersistentIdentifier {
        try perform { context in
            let descriptor = FetchDescriptor<StoredRepository>(
                predicate: #Predicate { $0.path == path }
            )
            if let existing = try context.fetch(descriptor).first {
                existing.name = name
                existing.owner = owner
                existing.currentBranch = currentBranch
                existing.syncStatusRaw = syncStatusRaw
                existing.updatedAt = .now
                return existing.persistentModelID
            } else {
                let repo = StoredRepository(
                    name: name,
                    owner: owner,
                    path: path,
                    currentBranch: currentBranch,
                    syncStatusRaw: syncStatusRaw
                )
                context.insert(repo)
                return repo.persistentModelID
            }
        }
    }

    /// Drop all cached commits and analytics snapshots for a given repository path.
    func invalidateCaches(forRepositoryPath path: String) throws {
        try perform { context in
            let descriptor = FetchDescriptor<StoredRepository>(
                predicate: #Predicate { $0.path == path }
            )
            guard let repo = try context.fetch(descriptor).first else { return }
            for cache in repo.commitCaches { context.delete(cache) }
            for snapshot in repo.analyticsSnapshots { context.delete(snapshot) }
        }
    }
}
