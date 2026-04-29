import Foundation
import SwiftData

extension SchemaV1 {
    /// Persistent pointer to an account whose secret material lives in the Keychain.
    ///
    /// `keychainAccount` is the Keychain item account string used to look up the OAuth or PAT
    /// token. **No token, refresh token, or password is ever stored in this model** — the
    /// Keychain remains the sole source of secret truth.
    @Model
    final class StoredAccountReference {
        @Attribute(.unique) var id: UUID
        var username: String
        var host: String
        var avatarSystemImage: String
        var keychainAccount: String
        var createdAt: Date
        var lastUsedAt: Date?

        init(
            id: UUID = UUID(),
            username: String,
            host: String,
            avatarSystemImage: String,
            keychainAccount: String,
            createdAt: Date = .now,
            lastUsedAt: Date? = nil
        ) {
            self.id = id
            self.username = username
            self.host = host
            self.avatarSystemImage = avatarSystemImage
            self.keychainAccount = keychainAccount
            self.createdAt = createdAt
            self.lastUsedAt = lastUsedAt
        }
    }
}
