//
//  WalletDetailViewController.swift
//  WalletApp
//

import Foundation

class WalletDetailViewController: BaseViewController {
  // MARK: - Properties
  private let balanceView: BalanceView
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
    viewModel.viewIsReady()
    setupBindables()
  }
  
  // MARK: - Setup
  private func setup() {
    setupBalanceView()
    setupBottomBarView()
  }
  
  private func setupBalanceView() {
    view.addSubview(balanceView)
    
    balanceView.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview()
      make.height.equalTo(155)
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
  
  // MARK: - Bindables
  private func setupBindables() {
    viewModel.viewState.bind { state in
    }
  }
}
