//
//  AccountDTO.swift
//  MVVMSwift
//
//  Created by David Seca on 14.07.22.
//  Copyright (c) 2022 David Seca. All rights reserved.
//

import Foundation

/// Support Struct for recovering from failing parse generic items
struct FailableDecodable<Base : Decodable> : Decodable {

    /// Decodable Object
    let base: Base?

    /// Constructor throwable
    ///  - parameters:
    ///     - decoder: Decoder to extract base data from
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.base = try? container.decode(Base.self)
    }

}

/// Data Transfer object for AccountService
class AccountServiceDTO: Decodable {

    // Just AccountService fields
    let failedAccountTypes: String
    let returnCode: String
    let accounts: [AccountDTO]

    enum CodingKeys: String, CodingKey {
        case failedAccountTypes
        case returnCode
        case accounts
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.failedAccountTypes = try container.decode(String.self, forKey: .failedAccountTypes)
        self.returnCode = try container.decode(String.self, forKey: .returnCode)
        self.accounts = try container.decode([FailableDecodable<AccountDTO>].self, forKey: .accounts).compactMap { $0.base }
    }

}

/// Data Transfer object for Account itself
struct AccountDTO: Decodable {

    // Just account fields
    let accountBalanceInCents: Int
    let accountCurrency: String
    let accountId: Int
    let accountName: String
    let accountNumber: Int
    let accountType: String
    let alias: String
    let iban: String
    let isVisible: Bool
    let linkedAccountId: Int?
    let productName: String?
    let productType: Int?
    let savingsTargetReached: Int?
    let targetAmountInCents: Int?

}
