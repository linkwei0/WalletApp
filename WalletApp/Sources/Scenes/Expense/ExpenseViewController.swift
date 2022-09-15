//
//  ExpenseViewController.swift
//  WalletApp
//

import UIKit

class ExpenseViewController: BaseViewController {
  // MARK: - Properties
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  // MARK: - Setups
  
  private func setup() {
    view.backgroundColor = .blue
  }
}
