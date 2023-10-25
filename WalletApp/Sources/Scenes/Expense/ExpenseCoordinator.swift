//
//  ExpenseCoordinator.swift
//  WalletApp
//

import UIKit

struct ExpenseCoordinatorConfiguration {
  let wallet: WalletModel
}

final class ExpenseCoordinator: ConfigurableCoordinator {
  typealias Configuration = ExpenseCoordinatorConfiguration
  typealias Factory = HasExpenseFactory
  
  // MARK: - Properties
  
  var childCoordinator: [Coordinator] = []
  var onDidFinish: (() -> Void)?
  
  let navigationController: NavigationController
  let appFactory: AppFactory
  
  private let factory: Factory
  private let configuration: Configuration
  
  required init(navigationController: NavigationController, appFactory: AppFactory, configuration: Configuration) {
    self.navigationController = navigationController
    self.appFactory = appFactory
    self.factory = appFactory
    self.configuration = configuration
  }
  
  func start(_ animated: Bool) {
    showExpenseScreen(animated: animated)
  }
  
  private func showExpenseScreen(animated: Bool) {
    let expenseVC = factory.expenseFactory.makeModule(with: configuration.wallet)
    expenseVC.navigationItem.title = NSDecimalNumber(decimal: configuration.wallet.balance).stringValue
    addPopObserver(for: expenseVC)
    navigationController.pushViewController(expenseVC, animated: animated)
  }
}
