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
  private let tableView = UITableView()
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
    viewModel.updateWallets()
    
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
    setupTableView()
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
      make.top.equalTo(balanceView.snp.bottom).offset(12)
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(40)
    }
  }
  
  private func setupTableView() {
    view.addSubview(tableView)
    tableView.rowHeight = 60
    tableView.separatorStyle = .none
    tableView.delegate = self
    tableView.register(WalletCell.self, forCellReuseIdentifier: WalletCell.reuseIdentifiable)
    tableView.snp.makeConstraints { make in
      make.top.equalTo(currencyView.snp.bottom).offset(12)
      make.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  private func setupAddWalletButton() {
    view.addSubview(addWalletButton)
    addWalletButton.setTitle("Добавить кошелек", for: .normal)
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
    tableView.dataSource = dataSource
    tableView.reloadData()
  }
  
  private func configureWalletsTableView(with state: SimpleViewState<WalletModel>) {
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
