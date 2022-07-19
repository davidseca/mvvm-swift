//
//  Account.swift
//  MVVMSwift
//
//  Created by David Seca on 14.07.22.
//  Copyright (c) 2022 David Seca. All rights reserved.
//

import Foundation
import CoreData


@objc(Account)
public class Account: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account")
    }

    @NSManaged public var accountBalanceInCents: Int
    @NSManaged public var accountCurrency: String
    @NSManaged public var accountId: Int
    @NSManaged public var accountName: String
    @NSManaged public var accountNumber: Int
    @NSManaged public var accountType: String
    @NSManaged public var alias: String
    @NSManaged public var iban: String
    @NSManaged public var isVisible: Bool

    var accountBalance: Double {
        return Double(self.accountBalanceInCents) / 100
    }

}
