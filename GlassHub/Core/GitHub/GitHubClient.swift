import Foundation

actor GitHubClient {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func validateConnection() async -> Bool {
        _ = session
        return true
    }
}
