//
//  BudgetPlanningViewController.swift
//  WalletApp
//
//  Created by Артём Бацанов on 15.11.2023.
//

import UIKit

class BudgetPlanningListViewController: UIViewController {
  // MARK: - Properties
  
  private let tableView = UITableView()
  
  private let dataSource = TableViewDataSource()
  
  let viewModel: BudgetPlanningListViewModel
  
  // MARK: - Init
  init(viewModel: BudgetPlanningListViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    setupBindables()
    viewModel.viewIsReady()
  }
  
  // MARK: - Setup
  private func setup() {
    setupTableView()
  }
  
  private func setupTableView() {
    view.addSubview(tableView)
    tableView.rowHeight = 150
    tableView.separatorStyle = .none
    tableView.register(BudgetPlanningHeaderView.self, 
                       forHeaderFooterViewReuseIdentifier: BudgetPlanningHeaderView.reuseIdentifiable)
    tableView.register(BudgetCell.self, forCellReuseIdentifier: BudgetCell.reuseIdentifiable)
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    dataSource.delegate = self
    dataSource.setup(tableView: tableView, viewModel: viewModel)
  }
  
  // MARK: - Private methods
  private func reloadTableView() {
    tableView.reloadData()
  }
  
  private func updateTableView(with indexPath: IndexPath) {
    tableView.insertRows(at: [indexPath], with: .automatic)
    tableView.reloadRows(at: [indexPath], with: .automatic)
  }
  
  // MARK: - Bindables
  private func setupBindables() {
    viewModel.onNeedsToUpdateTableView = { [weak self] in
      DispatchQueue.main.async {
        self?.reloadTableView()
      }
    }
    viewModel.onNeedsToUpdateRowAtTableView = { [weak self] indexPath in
      DispatchQueue.main.async {
        self?.updateTableView(with: indexPath)
      }
    }
  }
}

// MARK: - TableViewDataSourceDelegate
extension BudgetPlanningListViewController: TableViewDataSourceDelegate {
  func tableViewDataSource(_ dateSource: TableViewDataSource, heightForHeaderInSection section: Int) -> CGFloat? {
    return 40
  }
  
  func tableViewDataSource(_ dateSource: TableViewDataSource, heightForFooterInSection section: Int) -> CGFloat? {
    return 0
  }
}
