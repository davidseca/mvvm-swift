//
//  AccountViewModel.swift
//  MVVMSwift
//
//  Created by David Seca on 19.07.22.
//  Copyright © 2022 David Seca. All rights reserved.
//

import Foundation

/// Account ViewModel for packing fire methods and obserbable Boxings
public class AccountViewModel {

    /// Service to fetch accounts
    private let service = AccountService()

    // MARK: - private Raw Data

    /// All  acounts ViewData
    private var allAccounts = [AccountViewData]()

    /// Current viewMode
    private var viewMode = AccountViewMode.all

    // MARK: - Boxes

    /// Accounts Box
    let accountsBox = Box([AccountViewData]())

    /// ViewMode Box
    let viewModeBox = Box(AccountViewMode.all)

    // MARK: - Commands

    /// Load Accounts
    func loadAccounts() {
        service.loadIfNeeded { [weak self] (rawAccounts) in
            guard let self = self else {
                return
            }

            self.allAccounts = rawAccounts.map { AccountViewData.initialize(withAccount: $0) }
            self.updateBoxes()
        }
    }

    /// Change view Mode
    ///  - parameters: ViewMode RawValue to be set
    func changeViewMode(rawValue: Int) {
        self.viewMode = AccountViewMode(rawValue: rawValue) ?? .all
        self.updateBoxes()
    }

    // MARK: - Internal Logic and utilities

    /// Filter accounts based on viewMode
    /// - parameters:
    ///    -  accounts: Accounts to be filtered
    ///    -  viewMode: ViewMode to match
    /// - returns: Filtered accounts
    private func filter(accounts: [AccountViewData], viewMode: AccountViewMode) -> [AccountViewData] {
        switch viewMode {
        case .visible:
            return accounts.filter { $0.isVisible }
        default:
            return accounts
        }
    }

    /// Update Boxes with raw Data
    private func updateBoxes() {
        self.viewModeBox.value = self.viewMode
        self.accountsBox.value = self.filter(accounts: allAccounts, viewMode: viewMode)
    }

}
