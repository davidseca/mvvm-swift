//
//  AccountsViewController.swift
//  MVPSwift
//
//  Created by David Seca on 15.04.20.
//  Copyright © 2020 David Seca. All rights reserved.
//

import UIKit

class AccountsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewModeControl: UISegmentedControl!

    private var presenter = AccountPresenter()

    fileprivate static let cellIdentifier = "accountCell"

    /// current state of the UISegmentedControl
    private var viewMode = AccountViewMode.all

    /// All accounts gotten when accountsDidLoaded
    private var allAccounts = [AccountViewData]()

    /// Accounts to be displayed. Will change in function of viewMode
    private var accountsToDisplay = [AccountViewData]()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.title = L10n.Tabbar.accounts
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // mode control
        self.viewModeControl.setTitle(L10n.Accounts.ModeControl.all, forSegmentAt: 0)
        self.viewModeControl.setTitle(L10n.Accounts.ModeControl.visibles, forSegmentAt: 1)

        // tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: AccountsViewController.cellIdentifier)

        // Set presenter's delegate
        self.presenter.set(delegate: self)

        // Ready to init View UIs
        self.presenter.initView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Please load accounts
        self.presenter.loadAccounts()
    }

}

// MARK: - UISegmentedControl handler
extension AccountsViewController {

    @IBAction func viewModeValueChanged(_ sender: UISegmentedControl) {
        self.presenter.changeViewMode(rawValue: sender.selectedSegmentIndex)
    }

}

// MARK: - UITableViewDataSource, UITableViewDelegate delegate
extension AccountsViewController: UITableViewDataSource, UITableViewDelegate {

    // MARK: table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.accountsToDisplay.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountsViewController.cellIdentifier, for: indexPath)
        let account = self.accountsToDisplay[indexPath.row]
        cell.textLabel?.text = L10n.Accounts.Cell.info(account.number, account.balance)
        return cell
    }

}

// MARK: - TransactionDelegate
extension AccountsViewController: AccountViewDelegate {

    func accountsDidLoaded(accounts: [AccountViewData]) {
        self.allAccounts = accounts
        self.presenter.filter(accounts: self.allAccounts, viewMode: self.viewMode)
    }

    func viewModeDidChanged(viewMode: AccountViewMode) {
        self.viewModeControl.selectedSegmentIndex = viewMode.rawValue
        self.viewMode = viewMode
        self.presenter.filter(accounts: self.allAccounts, viewMode: self.viewMode)
    }

    func accountsDidFiltered(accounts: [AccountViewData]) {
        self.accountsToDisplay = accounts
        self.tableView.reloadData()
    }

}
