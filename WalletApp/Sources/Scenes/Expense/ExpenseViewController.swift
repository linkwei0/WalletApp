//
//  ExpenseViewController.swift
//  WalletApp
//

import UIKit

class ExpenseViewController: BaseViewController {
  // MARK: - Properties
  
  private let calculationView: CalculationView
  
  private let viewModel: ExpenseViewModel
  
  // MARK: - Init
  
  init(viewModel: ExpenseViewModel) {
    self.viewModel = viewModel
    calculationView = CalculationView(viewModel: viewModel.calculationViewModel)
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    self.viewModel = ExpenseViewModel(currentBank: "")
    calculationView = CalculationView(viewModel: viewModel.calculationViewModel)
    super.init(coder: coder)
  }

  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .accentDark
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
