//
//  OperationListCoordinator.swift
//  WalletApp
//
//  Created by Артём Бацанов on 08.11.2023.
//

import UIKit

struct OperationListCoordinatorConfiguration {
  let operations: [OperationModel]
}

class OperationListCoordinator: ConfigurableCoordinator {
  // MARK: - Properties
  typealias Configuration = OperationListCoordinatorConfiguration
  typealias Factory = HasOperationListFactory
  
  var childCoordinator: [Coordinator] = []
  var onDidFinish: (() -> Void)?
  
  let navigationController: NavigationController
  let appFactory: AppFactory
  
  private let configuration: Configuration
  private let factory: Factory
  
  // MARK: - Init
  required init(navigationController: NavigationController, appFactory: AppFactory,
                configuration: OperationListCoordinatorConfiguration) {
    self.navigationController = navigationController
    self.appFactory = appFactory
    self.configuration = configuration
    self.factory = appFactory
  }
  
  // MARK: - Start
  func start(_ animated: Bool) {
    showOperationsScreen(animated: animated)
  }
  
  private func showOperationsScreen(animated: Bool) {
    let viewController = factory.operationListFactory.makeModule(with: configuration.operations)
    viewController.navigationItem.title = R.string.walletDetail.operationListTitle()
    addPopObserver(for: viewController)
    navigationController.pushViewController(viewController, animated: animated)
  }
}
