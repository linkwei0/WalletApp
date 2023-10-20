//
//  IncomeViewController.swift
//  WalletApp
//

import UIKit

class IncomeViewController: BaseViewController {
  // MARK: - Properties
  private let calculationView: CalculationView
  
  private let viewModel: IncomeViewModel
  
  // MARK: - Init
  init(viewModel: IncomeViewModel) {
    self.viewModel = viewModel
    calculationView = CalculationView(viewModel: viewModel.calculationViewModel)
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .accentLight
    setup()
  }
  
  // MARK: - Setup
  private func setup() {
    setupCalculationView()
  }
  
  private func setupCalculationView() {
    view.addSubview(calculationView)
    calculationView.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview()
      make.bottom.equalTo(view.snp.bottom)
    }
  }
}
