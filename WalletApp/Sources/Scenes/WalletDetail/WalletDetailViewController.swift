//
//  WalletDetailViewController.swift
//  WalletApp
//
//  Created by Артём Бацанов on 16.10.2023.
//

import Foundation

class WalletDetailViewController: BaseViewController {
  // MARK: - Properties
  private let bottomBarView: BankBottomBarView
  
  let viewModel: WalletDetailViewModel
  
  // MARK: - Init
  init(viewModel: WalletDetailViewModel) {
    self.viewModel = viewModel
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
  }
  
  // MARK: - Setup
  private func setup() {
    setupBottomBarView()
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
}
