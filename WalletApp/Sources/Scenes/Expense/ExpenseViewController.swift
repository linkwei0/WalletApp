//
//  ExpenseViewController.swift
//  WalletApp
//

import UIKit

class ExpenseViewController: BaseViewController {
  // MARK: - Properties
  private let calculationView: CalculationView
  
  let viewModel: ExpenseViewModel
  
  // MARK: - Init
  init(viewModel: ExpenseViewModel) {
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
    setup()
  }
  
  override func willMove(toParent parent: UIViewController?) {
    super.willMove(toParent: parent)
    if parent == nil {
      viewModel.backToWalletDetail()
    }
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
