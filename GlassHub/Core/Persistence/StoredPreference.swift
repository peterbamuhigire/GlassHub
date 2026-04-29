import Foundation
import SwiftData

extension SchemaV1 {
    /// Key/value preference store for app-level settings that need to round-trip with the
    /// SwiftData store rather than `UserDefaults` (e.g. last-used sidebar selection,
    /// per-user UI state). Values are JSON-encoded for forward compatibility.
    @Model
    final class StoredPreference {
        @Attribute(.unique) var key: String
        var valueJSON: Data
        var updatedAt: Date

        init(key: String, valueJSON: Data, updatedAt: Date = .now) {
            self.key = key
            self.valueJSON = valueJSON
            self.updatedAt = updatedAt
        }
    }
}
