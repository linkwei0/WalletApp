//
//  WalletDetailViewController.swift
//  WalletApp
//

import UIKit

class WalletDetailViewController: BaseViewController {
  // MARK: - Properties
  private var dataSource: SimpleTableViewDataSoruce<OperationCellViewModelProtocol>?
  
  private let balanceView: BalanceView
  private let operationsTableView = UITableView()
  private let bottomBarView: BankBottomBarView
  
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
    operationsTableView.rowHeight = 60
    operationsTableView.backgroundColor = .baseWhite
    operationsTableView.register(OperationCell.self, forCellReuseIdentifier: OperationCell.reuseIdentifiable)
    operationsTableView.snp.makeConstraints { make in
      make.top.equalTo(balanceView.snp.bottom).offset(12)
      make.leading.trailing.bottom.equalToSuperview()
    }
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
    dataSource = SimpleTableViewDataSoruce.make(for: viewModel.cellViewModels)
    operationsTableView.dataSource = dataSource
    operationsTableView.reloadData()
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

// MARK: - UITableViewDataSource
//extension WalletDetailViewController: UITableViewDataSource {
//  func numberOfSections(in tableView: UITableView) -> Int {
//    return 2
//  }
//  
//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return 3
//  }
//  
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    guard let cell = tableView.dequeueReusableCell(withIdentifier: OperationCell.reuseIdentifiable,
//                                                   for: indexPath) as? OperationCell else { return UITableViewCell() }
//    cell.backgroundColor = .accent
//    return cell
//  }
//}
