//
//  AccountService.swift
//  MVVMSwift
//
//  Created by David Seca on 14.07.22.
//  Copyright (c) 2022 David Seca. All rights reserved.
//

import Foundation

/// Account Service to fetch accounts
public class AccountService {

    /// Manager for packing CoreData persistence container
    private let persistence = CoreDataManager.shared

    /// Low level Network service to get data from servers
    private var networkDelegate: NetworkManagerProtocol = NetworkManager.sharedInstance

    /// Flag to indicate if service is loading accounts
    private var loading = false

    // NB: For testing purposes
    func set(networkDelegate: NetworkManagerProtocol) {
        self.networkDelegate = networkDelegate
    }

    /// Attems to load Accounts from API and persists them
    /// - parameters:
    ///   - completion: Completion with array of fetched accounts
    func loadIfNeeded(completion: @escaping ([Account])->()) {
        if !self.loading {
            self.loading = true

            networkDelegate.getContent(content: .accounts) { data, isOffline in
                guard
                    let data = data
                else {
                    self.persistence.fetch(Account.self) { accounts in
                        completion(accounts)
                    }
                    return
                }

                let serviceDTO = try? JSONDecoder().decode(AccountServiceDTO.self, from: data)

                serviceDTO?.accounts.forEach { accountDTO in
                    let account = Account(context: self.persistence.context)
                    account.accountBalanceInCents = accountDTO.accountBalanceInCents
                    account.accountCurrency = accountDTO.accountCurrency
                    account.accountId = accountDTO.accountId
                    account.accountName = accountDTO.accountName
                    account.accountNumber = accountDTO.accountNumber
                    account.accountType = accountDTO.accountType
                    account.alias = accountDTO.alias
                    account.iban = accountDTO.iban
                    account.isVisible = accountDTO.isVisible
                }

                // Used CoreData as persistance.
                // NB: if complex queries needed and/or frequent changes on models, another approach like SQLite should reconsidered
                self.persistence.saveAndFetch(Account.self) { accounts in
                    completion(accounts)
                    self.loading = false
                }
            }
        }
    }
    
}
