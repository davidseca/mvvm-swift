//
//  AccountViewData.swift
//  MVVMSwift
//
//  Created by David Seca on 19.07.22.
//  Copyright © 2022 David Seca. All rights reserved.
//

import Foundation

// MARK: - AccountViewData

/// AccountViewData to be displayed
struct AccountViewData {

    /// Account number
    let number: String

    /// Account balance
    let balance: String

    /// Flag to indicate if Account visible
    let isVisible: Bool

    /// Initialize from an Account
    ///  - parameters:
    ///     - account: Account to initialize from
    ///  - returns: Generated AccountViewData
    static func initialize(withAccount account: Account) -> AccountViewData {
        return AccountViewData(number: "\(account.accountNumber)",
                               balance: String(format: "%.2f",
                               account.accountBalance),
                               isVisible: account.isVisible)
    }

}

// MARK: - AccountViewMode

/// Enum to summarize vew mode of account
public enum AccountViewMode: Int {
    case all
    case visible
}
