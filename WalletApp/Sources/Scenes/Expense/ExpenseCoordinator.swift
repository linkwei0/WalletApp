//
//  ExpenseCoordinator.swift
//  WalletApp
//

import UIKit

struct ExpenseCoordinatorConfiguration {
  let currentBank: String
}

final class ExpenseCoordinator: ConfigurableCoordinator {
  typealias Configuration = ExpenseCoordinatorConfiguration
  
  // MARK: - Properties
  
  var childCoordinator: [Coordinator] = []
  var onDidFinish: (() -> Void)?
  
  let navigationController: NavigationController
  let appDependency: AppDependency
  
  private let configuration: Configuration
  
  required init(navigationController: NavigationController, appDependency: AppDependency, configuration: Configuration) {
    self.navigationController = navigationController
    self.appDependency = appDependency
    self.configuration = configuration
  }
  
  func start(_ animated: Bool) {
    showExpenseScreen(animated: animated)
  }
  
  private func showExpenseScreen(animated: Bool) {
    let expenseViewModel = ExpenseViewModel(currentBank: configuration.currentBank)
    let expenseVC = ExpenseViewController(viewModel: expenseViewModel)
    expenseVC.navigationItem.title = configuration.currentBank
    navigationController.pushViewController(expenseVC, animated: animated)
  }
}
