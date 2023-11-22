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
  
  private let viewModel: BudgetPlanningListViewModel
  
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
    tableView.register(BudgetCell.self, forCellReuseIdentifier: BudgetCell.reuseIdentifiable)
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    dataSource.setup(tableView: tableView, viewModel: viewModel)
  }
  
  // MARK: - Private methods
  private func configureBudgetsTableView(with state: SimpleViewState<BudgetModel>) {
    switch state {
    case .initial:
      break
    case .populated:
      print("Hide empty budgets view")
    case .empty:
      print("Show empty budgets view")
    case .error(let error):
      print("Show error budgets view")
    }
  }
  
  private func reloadTableView() {
    tableView.reloadData()
  }
  
  // MARK: - Bindables
  private func setupBindables() {
    viewModel.viewState.bind { [weak self] state in
      DispatchQueue.main.async {
        self?.configureBudgetsTableView(with: state)
        self?.reloadTableView()
      }
    }
  }
}
