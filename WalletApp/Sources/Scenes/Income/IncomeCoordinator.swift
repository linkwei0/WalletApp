//
//  IncomeCoordinator.swift
//  WalletApp
//

import UIKit

struct IncomeCoordinatorConfiguration {
  let currentBank: String
}

final class IncomeCoordinator: ConfigurableCoordinator {
  typealias Configuration = IncomeCoordinatorConfiguration
  
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
    showIncomeScreen(animated: animated)
  }
  
  private func showIncomeScreen(animated: Bool) {
    let coreDataStack = CoreDataStack()
    let localDataSource = LocalDataSource(coreDataStack: coreDataStack)
    let useCase = UseCaseProvider(localDataSource: localDataSource)
    let interactor = CalculationInteractor(useCaseProvider: useCase)
    let incomeViewModel = IncomeViewModel(interactor: interactor, currentBank: configuration.currentBank)
    let incomeVC = IncomeViewController(viewModel: incomeViewModel)
    incomeVC.navigationItem.title = configuration.currentBank
    addPopObserver(for: incomeVC)
    navigationController.pushViewController(incomeVC, animated: animated)
  }
}
