//
//  WalletDetailViewController.swift
//  WalletApp
//

import UIKit

class WalletDetailViewController: BaseViewController {
  // MARK: - Properties
  private let balanceView: BalanceView
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
    setupBottomBarView()
  }
  
  private func setupBalanceView() {
    view.addSubview(balanceView)
    balanceView.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview()
      make.height.equalTo(155)
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
    operationsTableView.register(OperationSectionHeaderView.self,
                                 forHeaderFooterViewReuseIdentifier: OperationSectionHeaderView.reuseIdentifiable)
    operationsTableView.register(OperationItemCell.self, forCellReuseIdentifier: OperationItemCell.reuseIdentifiable)
    operationsTableView.snp.makeConstraints { make in
      make.top.equalTo(balanceView.snp.bottom).offset(16)
      make.leading.trailing.bottom.equalToSuperview()
    }
    dataSource.delegate = self
    dataSource.setup(tableView: operationsTableView, viewModel: viewModel)
  }
  
  private func setupBottomBarView() {
    view.addSubview(bottomBarView)
    bottomBarView.onDidSelectItem = { [weak self] itemType in
      self?.viewModel.didSelectBottomBarItem(itemType)
    }
    bottomBarView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(16)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16).priority(750)
      make.bottom.greaterThanOrEqualToSuperview().offset(-40)
    }
  }
  
  // MARK: - Private methods
  private func reloadTableView() {
    dataSource.update(with: viewModel)
  }
  
  private func configureWalletDetailTableView(with state: SimpleViewState<OperationModel>) {
    switch state {
    case .initial, .populated:
      print("Hide empty view")
    case .empty:
      print("Present empty view")
    case .error(let error):
      print("Present error \(error)")
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
  func tableViewDataSource(_ dateSource: TableViewDataSource, viewForFooterInSection section: Int) -> UIView? {
    return viewModel.isLastSection(section) ? UIView() : nil
  }
  
  func tableViewDataSource(_ dateSource: TableViewDataSource, heightForFooterInSection section: Int) -> CGFloat? {
    return viewModel.isLastSection(section) ? 65 : 0
  }
}
