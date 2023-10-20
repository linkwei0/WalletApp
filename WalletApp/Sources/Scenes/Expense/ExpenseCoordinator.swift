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
  let appFactory: AppFactory
  
  private let configuration: Configuration
  
  required init(navigationController: NavigationController, appFactory: AppFactory, configuration: Configuration) {
    self.navigationController = navigationController
    self.appFactory = appFactory
    self.configuration = configuration
  }
  
  func start(_ animated: Bool) {
    showExpenseScreen(animated: animated)
  }
  
  private func showExpenseScreen(animated: Bool) {
    let coreDataStack = CoreDataStack()
    let localDataSource: LocalDataSourceProtocol = LocalDataSource(coreDataStack: coreDataStack)
    let useCase = UseCaseProvider(localDataSource: localDataSource)
    let interactor = CalculationInteractor(useCaseProvider: useCase)
    let expenseViewModel = ExpenseViewModel(interactor: interactor, currentBank: configuration.currentBank)
    let expenseVC = ExpenseViewController(viewModel: expenseViewModel)
    expenseVC.navigationItem.title = configuration.currentBank
    navigationController.pushViewController(expenseVC, animated: animated)
  }
}
