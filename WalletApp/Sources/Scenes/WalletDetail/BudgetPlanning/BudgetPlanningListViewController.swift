//
//  BudgetPlanningViewController.swift
//  WalletApp
//
//  Created by Артём Бацанов on 15.11.2023.
//

import UIKit

class BudgetPlanningListViewController: UIViewController {
  // MARK: - Properties
  private let viewModel: BudgetPlanningListViewModel
  
  // MARK: - Init
  init(viewModel: BudgetPlanningListViewModel) {
    self.viewModel = viewModel
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
    view.backgroundColor = .baseWhite
  }
}
