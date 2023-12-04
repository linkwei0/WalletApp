//
//  OperationListViewController.swift
//  WalletApp
//
//  Created by Артём Бацанов on 08.11.2023.
//

import UIKit

class OperationListViewController: BaseViewController {
  // MARK: - Properties
  private let tableView = UITableView(frame: .zero, style: .grouped)
  
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
    setupBindables()
    viewModel.viewIsReady()
  }
  
  // MARK: - Setup
  private func setup() {
    setupTableView()
    setupRightBarButton()
  }
  
  private func setupRightBarButton() {
    let action = { (action: UIAction) in
      self.viewModel.didChangeSort(with: action.title)
    }
    var menuItems: [UIMenuElement] = []
    viewModel.sortedTypesList.forEach { menuItems.append(UIAction(title: $0, handler: action)) }
    let menu = UIMenu(options: .displayInline, children: menuItems)
    
    if #available(iOS 14.0, *) {
      let rightBarButton = UIBarButtonItem(image: UIImage(systemName: Constants.rightBarButtonImage))
      rightBarButton.menu = menu
      navigationItem.rightBarButtonItem = rightBarButton
    }
  }
  
  private func setupTableView() {
    view.addSubview(tableView)
    tableView.rowHeight = 50
    tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    tableView.separatorColor = .shade3
    tableView.showsVerticalScrollIndicator = true
    tableView.backgroundColor = .clear
    tableView.register(OperationItemCell.self, forCellReuseIdentifier: OperationItemCell.reuseIdentifiable)
    tableView.register(OperationDateHeaderView.self,
                       forHeaderFooterViewReuseIdentifier: OperationDateHeaderView.reuseIdentifiable)
    tableView.register(OperationHeaderView.self, forHeaderFooterViewReuseIdentifier: OperationHeaderView.reuseIdentifiable)
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
  
  // MARK: - Bindables
  private func setupBindables() {
    viewModel.onNeedsToUpdateTableView = { [weak self] in
      DispatchQueue.main.async {
        self?.reloadTableView()
      }
    }
  }
}

// MARK: - TableViewDataSourceDelegate
extension OperationListViewController: TableViewDataSourceDelegate {
  func tableViewDataSource(_ dateSource: TableViewDataSource, heightForHeaderInSection section: Int) -> CGFloat? {
    return 60
  }
  
  func tableViewDataSource(_ dateSource: TableViewDataSource, heightForFooterInSection section: Int) -> CGFloat? {
    return 50
  }
}

private extension Constants {
  static let rightBarButtonImage = "list.bullet"
}
