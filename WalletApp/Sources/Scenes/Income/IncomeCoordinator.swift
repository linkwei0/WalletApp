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
  let appDependency: AppDependency
  
  private let configuration: Configuration
  
  required init(navigationController: NavigationController, appDependency: AppDependency, configuration: Configuration) {
    self.navigationController = navigationController
    self.appDependency = appDependency
    self.configuration = configuration
  }
  
  func start(_ animated: Bool) {
    showIncomeScreen(animated: animated)
  }
  
  private func showIncomeScreen(animated: Bool) {
    let incomeViewModel = IncomeViewModel(currentBank: configuration.currentBank)
    let incomeVC = IncomeViewController(viewModel: incomeViewModel)
    incomeVC.navigationItem.title = configuration.currentBank
    addPopObserver(for: incomeVC)
    navigationController.pushViewController(incomeVC, animated: animated)
  }
}
