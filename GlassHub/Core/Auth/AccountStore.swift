import Foundation

actor AccountStore {
    private var accounts: [GitHubAccount] = SampleData.accounts

    func allAccounts() -> [GitHubAccount] {
        accounts
    }

    func add(_ account: GitHubAccount) {
        accounts.append(account)
    }
}
