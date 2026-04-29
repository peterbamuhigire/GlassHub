import Foundation

enum FuzzyIndex {
    static func matches(needle: String, haystack: String) -> Bool {
        let query = needle.lowercased()
        let text = haystack.lowercased()

        guard !query.isEmpty else { return true }
        if text.contains(query) { return true }

        var searchStart = text.startIndex
        for character in query {
            guard let match = text[searchStart...].firstIndex(of: character) else {
                return false
            }
            searchStart = text.index(after: match)
        }
        return true
    }
}
