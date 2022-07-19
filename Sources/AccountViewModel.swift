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

    /// Accounts Box
    let accounts = Box([AccountViewData]())

    /// ViewMode Box
    let viewMode = Box(AccountViewMode.all)

    /// Load Accounts
    func loadAccounts() {
        service.loadIfNeeded { [weak self] (rawAccounts) in
            self?.accounts.value = rawAccounts.map { AccountViewData.initialize(withAccount: $0) }
        }
    }

    /// Change view Mode
    ///  - parameters: ViewMode RawValue to be set
    func changeViewMode(rawValue: Int) {
        self.viewMode.value = AccountViewMode(rawValue: rawValue) ?? .all
    }

}
