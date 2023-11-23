//
//  BudgetDetailCoordinator.swift
//  WalletApp
//
//  Created by Артём Бацанов on 23.11.2023.
//

import Foundation

struct BudgetDetailCoordinatorConfiguration {
  let budget: BudgetModel
  let currencyCode: String
}

class BudgetDetailCoordinator: ConfigurableCoordinator {
  typealias Configuration = BudgetDetailCoordinatorConfiguration
  typealias Factory = HasBudgetDetailFactory
  
  var childCoordinator: [Coordinator] = []
  var onDidFinish: (() -> Void)?
  
  let navigationController: NavigationController
  let appFactory: AppFactory
  
  private let configuration: Configuration
  private let factory: Factory
  
  required init(navigationController: NavigationController, appFactory: AppFactory, configuration: Configuration) {
    self.navigationController = navigationController
    self.appFactory = appFactory
    self.configuration = configuration
    self.factory = appFactory
  }
  
  func start(_ animated: Bool) {
    showBudgetDetailScreen(animated: animated)
  }
  
  private func showBudgetDetailScreen(animated: Bool) {
    let viewController = factory.budgetDetailFactory.makeModule(budget: configuration.budget, 
                                                                currencyCode: configuration.currencyCode)
    viewController.modalPresentationStyle = .overCurrentContext
    navigationController.present(viewController, animated: animated)
  }
}
