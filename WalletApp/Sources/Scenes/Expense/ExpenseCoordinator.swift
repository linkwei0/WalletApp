//
//  ExpenseCoordinator.swift
//  WalletApp
//

import UIKit

class ExpenseCoordinator: Coordinator {
  var childCoordinator: [Coordinator] = []
  var onDidFinish: (() -> Void)?
  
  let navigationController: UINavigationController
  let appDependency: AppDependency
  
  
  required init(navigationController: UINavigationController, appDependency: AppDependency) {
    self.navigationController = navigationController
    self.appDependency = appDependency
  }
  
  func start(_ animated: Bool) {
    showExpenseScreen(animated: animated)
  }
  
  private func showExpenseScreen(animated: Bool) {
    let expenseVC = ExpenseViewController()
    navigationController.pushViewController(expenseVC, animated: animated)
  }
}
