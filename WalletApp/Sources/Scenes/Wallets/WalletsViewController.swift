//
//  WalletsViewController.swift
//  WalletApp
//

import UIKit

class WalletsViewController: BaseViewController {
  // MARK: - Properties
  private var dataSource: SimpleTableViewDataSoruce<WalletCellViewModelProtocol>?
  
  private let balanceView: BalanceView
  private let currencyView: CurrencyView
  private let emptyStateView = EmptyStateView()
  private let walletsTableView = UITableView()
  private let addWalletButton = UIButton(type: .system)
  
  let viewModel: WalletsViewModel
  
  // MARK: - Init
  
  init(viewModel: WalletsViewModel) {
    self.viewModel = viewModel
    self.balanceView = BalanceView(viewModel: viewModel.balanceViewModel)
    self.currencyView = CurrencyView(viewModel: viewModel.currencyViewModel)
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
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)    
    balanceView.alpha = 0.0
    currencyView.alpha = 0.0
    addWalletButton.alpha = 0.0
    navigationController?.navigationBar.alpha = 0.0
    UIView.animate(withDuration: 0.45, delay: 0.0, options: .curveLinear) {
      self.navigationController?.navigationBar.alpha = 1.0
      self.balanceView.alpha = 1.0
      self.currencyView.alpha = 1.0
      self.addWalletButton.alpha = 1.0
    }
  }
  
  // MARK: - Setups
  
  private func setup() {
    setupBalanceView()
    setupCurrenciesView()
    setupWalletsTableView()
    setupEmptyStateView()
    setupAddWalletButton()
  }
  
  private func setupBalanceView() {
    view.addSubview(balanceView)
    
    balanceView.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview()
      make.height.equalTo(155)
    }
  }
  
  private func setupCurrenciesView() {
    view.addSubview(currencyView)
    currencyView.snp.makeConstraints { make in
      make.top.equalTo(balanceView.snp.bottom).offset(8)
      make.leading.trailing.equalToSuperview().inset(12)
      make.height.equalTo(40)
    }
  }
  
  private func setupWalletsTableView() {
    view.addSubview(walletsTableView)
    walletsTableView.rowHeight = 60
    walletsTableView.separatorStyle = .none
    walletsTableView.delegate = self
    walletsTableView.register(WalletCell.self, forCellReuseIdentifier: WalletCell.reuseIdentifiable)
    walletsTableView.snp.makeConstraints { make in
      make.top.equalTo(currencyView.snp.bottom)
      make.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  func handleRefreshButtonTapped() {
    viewModel.viewIsReady()
  }
  
  private func setupEmptyStateView() {
    view.addSubview(emptyStateView)
    emptyStateView.isHidden = true
    emptyStateView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(16)
      make.center.equalToSuperview()
    }
  }
  
  private func setupAddWalletButton() {
    view.addSubview(addWalletButton)
    addWalletButton.setTitle(R.string.wallets.walletsButtonAddTitle(), for: .normal)
    addWalletButton.setTitleColor(.baseWhite, for: .normal)
    addWalletButton.titleLabel?.font = UIFont.bodyBold ?? .boldSystemFont(ofSize: 16)
    addWalletButton.layer.cornerRadius = 12
    addWalletButton.backgroundColor = .accent
    addWalletButton.layer.borderWidth = 2.0
    addWalletButton.layer.borderColor = UIColor.accentDark.cgColor
    addWalletButton.addTarget(self, action: #selector(didTapAddWalletButton), for: .touchUpInside)
    addWalletButton.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(16)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
      make.height.equalTo(60)
    }
  }
  
  // MARK: - Private methods
  private func reloadTableView() {
    dataSource = SimpleTableViewDataSoruce.make(for: viewModel.cellViewModels)
    walletsTableView.dataSource = dataSource
    walletsTableView.reloadData()
  }
  
  private func configureWalletsTableView(with state: SimpleViewState<WalletModel>) {
    switch state {
    case .initial:
      emptyStateView.isHidden = true
      walletsTableView.isHidden = true
    case .populated:
      emptyStateView.isHidden = true
      walletsTableView.isHidden = false
    case .empty:
      if let emptyViewModel = viewModel.emptyStateViewModel {
        emptyStateView.configure(with: emptyViewModel)
      }
      walletsTableView.isHidden = true
      emptyStateView.isHidden = false
    case .error(let error):
      if let emptyViewModel = viewModel.emptyStateViewModel {
        emptyStateView.configure(with: emptyViewModel)
      }
      walletsTableView.isHidden = true
      emptyStateView.isHidden = true
    }
  }
  
  // MARK: - Bindables
  private func setupBindables() {
    viewModel.viewState.bind { [weak self] state in
      guard let strongSelf = self else { return }
      DispatchQueue.main.async {
        strongSelf.configureWalletsTableView(with: state)
        strongSelf.reloadTableView()
      }
    }
  }
  
  // MARK: - Actions
  @objc private func didTapAddWalletButton() {
    viewModel.addNewPersonWallet()
  }
}

// MARK: - UITableViewDelegate
extension WalletsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.showSelectedWallet(at: indexPath.row)
  }
}
