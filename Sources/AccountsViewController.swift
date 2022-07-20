//
//  AccountsViewController.swift
//  MVVMSwift
//
//  Created by David Seca on 14.07.22.
//  Copyright (c) 2022 David Seca. All rights reserved.
//

import UIKit

/// View Controller for Accounts
class AccountsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewModeControl: UISegmentedControl!

    /// Account View Model
    private let viewModel = AccountViewModel()

    /// Just account Cell Indentifier
    fileprivate static let cellIdentifier = "accountCell"

    /// Current state of the UISegmentedControl
    private var viewMode = AccountViewMode.all

    /// Accounts to display
    private var accounts = [AccountViewData]()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.title = L10n.Tabbar.accounts
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // mode control
        self.viewModeControl.setTitle(L10n.Accounts.ModeControl.all, forSegmentAt: 0)
        self.viewModeControl.setTitle(L10n.Accounts.ModeControl.visibles, forSegmentAt: 1)

        // tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: AccountsViewController.cellIdentifier)

        // Bind ViewModel Boxes
        self.bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Please load accounts
        self.viewModel.loadAccounts()
    }

}

// MARK: - Bind ViewModel Boxes
extension AccountsViewController {

    /// Bind ViewModel Boxes
    private func bindViewModel() {
        self.viewModel.accountsBox.bind { [weak self] accounts in
            self?.accounts = accounts
            self?.tableView.reloadData()
        }

        self.viewModel.viewModeBox.bind { [weak self] viewMode in
            self?.viewModeControl.selectedSegmentIndex = viewMode.rawValue
        }
    }

}

// MARK: - UISegmentedControl handler
extension AccountsViewController {

    @IBAction func viewModeValueChanged(_ sender: UISegmentedControl) {
        self.viewModel.changeViewMode(rawValue: sender.selectedSegmentIndex)
    }

}

// MARK: - UITableViewDataSource, UITableViewDelegate delegate
extension AccountsViewController: UITableViewDataSource, UITableViewDelegate {

    // MARK: table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.accounts.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountsViewController.cellIdentifier, for: indexPath)
        let account = self.accounts[indexPath.row]
        cell.textLabel?.text = L10n.Accounts.Cell.info(account.number, account.balance)
        return cell
    }

}
