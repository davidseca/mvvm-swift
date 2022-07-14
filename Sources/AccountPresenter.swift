//
//  AccountManager.swift
//  MVVMSwift
//
//  Created by David Seca on 15.04.20.
//  Copyright © 2020 David Seca. All rights reserved.
//

// MARK: - AccountViewData
/// AccountViewData to be displayed
struct AccountViewData {
    let number: String
    let balance: String
    let isVisible: Bool
}

extension AccountViewData {
    fileprivate static func initialize(withAccount account: Account) -> AccountViewData {
        return AccountViewData(number: "\(account.accountNumber)",
                               balance: String(format: "%.2f",
                               account.accountBalance),
                               isVisible: account.isVisible)
    }
}

// MARK: - AccountViewMode
/// Views mode of accounts
public enum AccountViewMode: Int {
    case all
    case visible
}

// MARK: - AccountViewDelegate
/// AccountView Delegate
protocol AccountViewDelegate: class {

    func accountsDidLoaded(accounts: [AccountViewData])

    func viewModeDidChanged(viewMode: AccountViewMode)

    func accountsDidFiltered(accounts: [AccountViewData])

}

// MARK: - AccountPresenter
/// Account Presenter
class AccountPresenter {

    private weak var delegate: AccountViewDelegate?

    private let service = AccountService()

    func set(delegate: AccountViewDelegate) {
        self.delegate = delegate
    }

    // NB: For testing purposes
    func set(networkDelegate: NetworkManagerProtocol) {
        self.service.set(networkDelegate: networkDelegate)
    }

    func initView() {
        self.delegate?.viewModeDidChanged(viewMode: .all)
    }

    func changeViewMode(rawValue: Int) {
        let viewMode = AccountViewMode(rawValue: rawValue) ?? .all
        self.delegate?.viewModeDidChanged(viewMode: viewMode)
    }

    func filter(accounts: [AccountViewData], viewMode: AccountViewMode) {
        switch viewMode {
        case .all:
            self.delegate?.accountsDidFiltered(accounts: accounts)
        case .visible:
            self.delegate?.accountsDidFiltered(accounts: accounts.filter { $0.isVisible })
        }
    }

    /// Load Accounts
    func loadAccounts() {
        service.loadIfNeeded { [ weak self] (accounts) in
            let accountsViewData = accounts.map { AccountViewData.initialize(withAccount: $0) }
            self?.delegate?.accountsDidLoaded(accounts: accountsViewData)
        }
    }

}
