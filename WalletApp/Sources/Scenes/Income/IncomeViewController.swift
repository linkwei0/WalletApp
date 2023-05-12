//
//  IncomeViewController.swift
//  WalletApp
//

import UIKit

class IncomeViewController: BaseViewController {
  // MARK: - Properties
  
  private let calculationView = CalculationView()
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  // MARK: - Setups
  
  private func setup() {
    setupCalculationView()
  }
  
  private func setupCalculationView() {
    view.addSubview(calculationView)
    calculationView.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview()
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(12)
    }
  }
}
