//
//  AccountDTO.swift
//  MVVMSwift
//
//  Created by David Seca on 15.04.20.
//  Copyright © 2020 David Seca. All rights reserved.
//

import Foundation

/// Support Struct for recovering from failing parse items
struct FailableDecodable<Base : Decodable> : Decodable {

    let base: Base?

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.base = try? container.decode(Base.self)
    }
}

class AccountServiceDTO: Decodable {
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

struct AccountDTO: Decodable {
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
