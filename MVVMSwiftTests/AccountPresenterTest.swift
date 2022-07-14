//
//  AccountPresenterTest.swift
//  MVVMSwiftTests
//
//  Created by David Seca on 14.07.22.
//  Copyright (c) 2022 David Seca. All rights reserved.
//

import XCTest

@testable import MVVMSwift

class AccountPresenterTest: XCTestCase {

    func testLoadAccounts() {
        // given
        let expec = expectation(description: "load accounts")
        let vc = MockAccountVC1(expectation: expec)
        let presenter = AccountPresenter()
        presenter.set(delegate: vc)
        presenter.set(networkDelegate: MockNetworkManager())

        // when
        presenter.loadAccounts()
        wait(for: [expec], timeout: 3)

        // then
        XCTAssert(vc.allAccounts.count == 2)
    }

    func testChangeViewMode() {
        // given
        let expec = expectation(description: "change viewMode")
        let vc = MockAccountVC1(expectation: expec)
        let presenter = AccountPresenter()
        presenter.set(delegate: vc)

        // when
        presenter.changeViewMode(rawValue: 1)
        wait(for: [expec], timeout: 3)

        // then
        XCTAssert(vc.viewMode == .visible)
    }

    func testFilterAccounts() {
        // given
        let expec = expectation(description: "filter accounts")
        let vc = MockAccountVC1(expectation: expec)
        let presenter = AccountPresenter()
        presenter.set(delegate: vc)


        let accounts = [AccountViewData(number: "1", balance: "10", isVisible: true),
                        AccountViewData(number: "2", balance: "20", isVisible: false),
                        AccountViewData(number: "3", balance: "30", isVisible: true)]

        // when
        presenter.filter(accounts: accounts, viewMode: .visible)

        // then
        wait(for: [expec], timeout: 3)
        XCTAssert(vc.accountsToDisplay.count == 2)
    }
}

class MockAccountVC1: AccountViewDelegate {

    var expec: XCTestExpectation
    var allAccounts = [AccountViewData]()
    var accountsToDisplay = [AccountViewData]()
    var viewMode = AccountViewMode.all

    init(expectation: XCTestExpectation) {
        self.expec = expectation
    }

    func accountsDidLoaded(accounts: [AccountViewData]) {
        self.allAccounts = accounts
        self.expec.fulfill()
    }

    func viewModeDidChanged(viewMode: AccountViewMode) {
        self.viewMode = viewMode
        self.expec.fulfill()
    }

    func accountsDidFiltered(accounts: [AccountViewData]) {
        self.accountsToDisplay = accounts
        self.expec.fulfill()
    }

}
