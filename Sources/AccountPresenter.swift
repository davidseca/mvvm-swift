//
//  AccountManager.swift
//  MVVMSwift
//
//  Created by David Seca on 14.07.22.
//  Copyright (c) 2022 David Seca. All rights reserved.
//



// MARK: - AccountViewDelegate
/// AccountView Delegate
protocol AccountViewDelegate: AnyObject {

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
