//
//  OperationListViewController.swift
//  WalletApp
//
//  Created by Артём Бацанов on 08.11.2023.
//

import UIKit

class OperationListViewController: BaseViewController {
  // MARK: - Properties
  private let tableView = UITableView()
  
  private let dataSource = TableViewDataSource()
  private let viewModel: OperationListViewModel
  
  // MARK: - Init
  init(viewModel: OperationListViewModel) {
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
    viewModel.viewIsReady()
  }
  
  // MARK: - Setup
  private func setup() {
    setupTableView()
  }
  
  private func setupTableView() {
    view.addSubview(tableView)
    tableView.estimatedRowHeight = UITableView.automaticDimension
    tableView.separatorStyle = .none
    tableView.rowHeight = 40
    tableView.showsVerticalScrollIndicator = false
    tableView.register(OperationItemCell.self, forCellReuseIdentifier: OperationItemCell.reuseIdentifiable)
    tableView.register(OperationDateHeaderView.self,
                       forHeaderFooterViewReuseIdentifier: OperationDateHeaderView.reuseIdentifiable)
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    dataSource.delegate = self
    dataSource.setup(tableView: tableView, viewModel: viewModel)
  }
}

// MARK: - TableViewDataSourceDelegate
extension OperationListViewController: TableViewDataSourceDelegate {
  func tableViewDataSource(_ dateSource: TableViewDataSource, heightForHeaderInSection section: Int) -> CGFloat? {
    return 40
  }
  
  func tableViewDataSource(_ dateSource: TableViewDataSource, heightForFooterInSection section: Int) -> CGFloat? {
    return 0
  }
}
