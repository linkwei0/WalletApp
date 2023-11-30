//
//  WalletDetailViewController.swift
//  WalletApp
//

import UIKit

class WalletDetailViewController: BaseViewController {
  // MARK: - Properties
  private let balanceView: BalanceView
  private let emptyStateView = EmptyStateView()
  private let tableView = UITableView(frame: .zero, style: .grouped)
  private let bottomBarView: WalletBottomBarView
  
  private let dataSource = TableViewDataSource()
  
  let viewModel: WalletDetailViewModel
  
  // MARK: - Init
  init(viewModel: WalletDetailViewModel) {
    self.viewModel = viewModel
    self.balanceView = BalanceView(viewModel: viewModel.balanceViewModel)
    self.bottomBarView = WalletBottomBarView(configuration: viewModel.bottomBarConfiguration)
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
    setupBackground()
    setupBalanceView()
    setupOperationsTableView()
    setupEmptyStateView()
    setupBottomBarView()
  }
  
  private func setupBackground() {
    view.backgroundColor = .systemGroupedBackground
  }
  
  private func setupBalanceView() {
    view.addSubview(balanceView)
    balanceView.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview()
      make.height.equalTo(115)
    }
  }
  
  private func setupOperationsTableView() {
    view.addSubview(tableView)
    tableView.separatorStyle = .none
    tableView.showsVerticalScrollIndicator = false
    tableView.rowHeight = 190
//    tableView.rowHeight = UITableView.automaticDimension
    tableView.backgroundColor = .clear
    tableView.register(WalletDetailCell.self, forCellReuseIdentifier: WalletDetailCell.reuseIdentifiable)
    tableView.register(OperationLastSectionFooterView.self,
                       forHeaderFooterViewReuseIdentifier: OperationLastSectionFooterView.reuseIdentifiable)
    tableView.register(OperationHeaderView.self, forHeaderFooterViewReuseIdentifier: OperationHeaderView.reuseIdentifiable)
    tableView.snp.makeConstraints { make in
      make.top.equalTo(balanceView.snp.bottom)
      make.leading.trailing.bottom.equalToSuperview()
    }
    dataSource.delegate = self
    dataSource.setup(tableView: tableView, viewModel: viewModel)
  }
  
  private func setupEmptyStateView() {
    view.addSubview(emptyStateView)
    emptyStateView.isHidden = true
    emptyStateView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(16)
      make.center.equalToSuperview()
    }
  }
  
  private func setupBottomBarView() {
    view.addSubview(bottomBarView)
    bottomBarView.onDidSelectItem = { [weak self] itemType in
      self?.viewModel.didSelectBottomBarItem(itemType)
    }
    bottomBarView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(16)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-6)
      make.height.equalTo(50)
    }
  }
  
  // MARK: - Private methods
  private func reloadTableView() {
    tableView.reloadData()
  }
  
  private func configureWalletDetailTableView(with state: SimpleViewState<OperationModel>) {
    switch state {
    case .initial:
      emptyStateView.isHidden = true
      tableView.isHidden = true
    case .populated:
      emptyStateView.isHidden = true
      tableView.isHidden = false
    case .empty:
      if let emptyViewModel = viewModel.emptyStateViewModel {
        emptyStateView.configure(with: emptyViewModel)
        emptyStateView.isHidden = false
        tableView.isHidden = true
      }
    case .error(let error):
      // TODO: - Error view
      if let emptyViewModel = viewModel.emptyStateViewModel {
        emptyStateView.configure(with: emptyViewModel)
      }
      emptyStateView.isHidden = false
      tableView.isHidden = true
    }
  }
  
  // MARK: - Bindables
  private func setupBindables() {
    viewModel.viewState.bind { [weak self] state in
      guard let strongSelf = self else { return }
      DispatchQueue.main.async {
        strongSelf.reloadTableView()
        strongSelf.configureWalletDetailTableView(with: state)
      }
    }
  }
}

// MARK: - TableViewDataSourceDelegate
extension WalletDetailViewController: TableViewDataSourceDelegate {
  func tableViewDataSource(_ dateSource: TableViewDataSource, heightForHeaderInSection section: Int) -> CGFloat? {
    return viewModel.isLastSection(section) ? 50 : 10
  }
  
  func tableViewDataSource(_ dateSource: TableViewDataSource, heightForFooterInSection section: Int) -> CGFloat? {
    return viewModel.isLastSection(section) ? 160 : 0
  }
}
