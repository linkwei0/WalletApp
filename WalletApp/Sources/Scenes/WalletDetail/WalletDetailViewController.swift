//
//  WalletDetailViewController.swift
//  WalletApp
//

import UIKit

class WalletDetailViewController: BaseViewController {
  // MARK: - Properties
  private let balanceView: BalanceView
  private let emptyStateView = EmptyStateView()
  private let operationsTableView = UITableView(frame: .zero, style: .grouped)
  private let bottomBarView: BankBottomBarView
  
  private let dataSource = TableViewDataSource()
  
  let viewModel: WalletDetailViewModel
  
  // MARK: - Init
  init(viewModel: WalletDetailViewModel) {
    self.viewModel = viewModel
    self.balanceView = BalanceView(viewModel: viewModel.balanceViewModel)
    self.bottomBarView = BankBottomBarView(configuration: viewModel.bottomBarConfiguration)
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
    setupBalanceView()
    setupOperationsTableView()
    setupEmptyStateView()
    setupBottomBarView()
  }
  
  private func setupBalanceView() {
    view.addSubview(balanceView)
    balanceView.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview()
      make.height.equalTo(115)
    }
  }
  
  private func setupOperationsTableView() {
    view.addSubview(operationsTableView)
    operationsTableView.separatorStyle = .none
    operationsTableView.showsVerticalScrollIndicator = false
    operationsTableView.estimatedRowHeight = 50
    operationsTableView.rowHeight = UITableView.automaticDimension
    operationsTableView.backgroundColor = .baseWhite
    operationsTableView.automaticallyAdjustsScrollIndicatorInsets = false
    operationsTableView.register(OperationHeaderView.self,
                                 forHeaderFooterViewReuseIdentifier: OperationHeaderView.reuseIdentifiable)
    operationsTableView.register(OperationLastSectionFooterView.self,
                                 forHeaderFooterViewReuseIdentifier: OperationLastSectionFooterView.reuseIdentifiable)
    operationsTableView.register(OperationItemCell.self, forCellReuseIdentifier: OperationItemCell.reuseIdentifiable)
    operationsTableView.register(OperationDefaultFooterView.self,
                                 forHeaderFooterViewReuseIdentifier: OperationDefaultFooterView.reuseIdentifiable)
    operationsTableView.snp.makeConstraints { make in
      make.top.equalTo(balanceView.snp.bottom)
      make.leading.trailing.bottom.equalToSuperview()
    }
    dataSource.delegate = self
    dataSource.setup(tableView: operationsTableView, viewModel: viewModel)
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
    dataSource.update(with: viewModel)
  }
  
  private func configureWalletDetailTableView(with state: SimpleViewState<OperationModel>) {
    switch state {
    case .initial:
      emptyStateView.isHidden = true
      operationsTableView.isHidden = true
    case .populated:
      emptyStateView.isHidden = true
      operationsTableView.isHidden = false
    case .empty:
      if let emptyViewModel = viewModel.emptyStateViewModel {
        emptyStateView.configure(with: emptyViewModel)
        emptyStateView.isHidden = false
        operationsTableView.isHidden = true
      }
    case .error(let error):
      // TODO: - Error view
      if let emptyViewModel = viewModel.emptyStateViewModel {
        emptyStateView.configure(with: emptyViewModel)
      }
      emptyStateView.isHidden = false
      operationsTableView.isHidden = true
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
    return viewModel.isLastSection(section) ? 60 : 50
  }
  
  func tableViewDataSource(_ dateSource: TableViewDataSource, heightForFooterInSection section: Int) -> CGFloat? {
    return viewModel.isLastSection(section) ? 160 : 50
  }
}
