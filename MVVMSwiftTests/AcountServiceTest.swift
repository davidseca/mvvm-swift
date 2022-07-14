//
//  AcountServiceTest.swift
//  MVVMSwiftTests
//
//  Created by David Seca on 14.07.22.
//  Copyright (c) 2022 David Seca. All rights reserved.
//

import XCTest

@testable import MVVMSwift

class AcountServiceTest: XCTestCase {

    func test_accounts_parse() {

        // given
        let accountService = AccountService()
        accountService.set(networkDelegate: MockNetworkManager())

        // when
        var testAccounts = [Account]()
        let expectation = self.expectation(description: "AccountLoad")
        accountService.loadIfNeeded { accounts in
            testAccounts = accounts
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)

        // then
        XCTAssert(testAccounts.count == 2)
    }

    func test_accounts_visible() {

        // given
        let accountService = AccountService()
        accountService.set(networkDelegate: MockNetworkManager())

        // when
        var testAccounts = [Account]()
        let expectation = self.expectation(description: "AccountLoad")
        accountService.loadIfNeeded { accounts in
            testAccounts = accounts
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)

        // then
        let visibleAccounts = testAccounts.filter { $0.isVisible }
        let noVisibleAccounts = testAccounts.filter { !$0.isVisible }
        XCTAssert(visibleAccounts.count == 1)
        XCTAssert(visibleAccounts.first?.accountId == 748757694)
        XCTAssert(noVisibleAccounts.count == 1)
        XCTAssert(noVisibleAccounts.first?.accountId == 700000027559)
    }
}
