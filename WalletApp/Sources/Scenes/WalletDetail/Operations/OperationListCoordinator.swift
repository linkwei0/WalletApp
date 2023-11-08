//
//  OperationListCoordinator.swift
//  WalletApp
//
//  Created by Артём Бацанов on 08.11.2023.
//

import Foundation

struct OperationListCoordinatorConfiguration {
  let operations: [OperationModel]
}

class OperationListCoordinator: ConfigurableCoordinator {
  typealias Configuration = OperationListCoordinatorConfiguration
  
  var childCoordinator: [Coordinator] = []
  var onDidFinish: (() -> Void)?
  
  let navigationController: NavigationController
  let appFactory: AppFactory
  
  private let configuration: Configuration
  
  required init(navigationController: NavigationController, appFactory: AppFactory,
                configuration: OperationListCoordinatorConfiguration) {
    self.navigationController = navigationController
    self.appFactory = appFactory
    self.configuration = configuration
  }
  
  func start(_ animated: Bool) {
    showOperationsScreen(animated: animated)
  }
  
  private func showOperationsScreen(animated: Bool) {
    let viewModel = OperationListViewModel(operations: configuration.operations)
    let viewController = OperationListViewController(viewModel: viewModel)
    viewController.navigationItem.title = "Операции"
    navigationController.pushViewController(viewController, animated: animated)
  }
}
