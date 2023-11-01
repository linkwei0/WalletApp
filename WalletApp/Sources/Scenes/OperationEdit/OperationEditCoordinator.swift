//
//  OperationEditCoordinator.swift
//  WalletApp
//
//  Created by Артём Бацанов on 31.10.2023.
//

import Foundation

protocol OperationEditCoordinatorDelegate: AnyObject {
  func operationEditCoordinatorSuccessfullyEdited(_ coordinator: OperationEditCoordinator)
}

struct OperationEditCoordinatorConfiguration {
  let wallet: WalletModel
  let operation: OperationModel
}

class OperationEditCoordinator: ConfigurableCoordinator {
  typealias Configuration = OperationEditCoordinatorConfiguration
  typealias Factory = HasOperationEditFactory
  
  weak var delegate: OperationEditCoordinatorDelegate?
  
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
    showOperationEditScreen(animated: animated)
  }
  
  private func showOperationEditScreen(animated: Bool) {
    let viewController = factory.operationEditFactory.makeModule(wallet: configuration.wallet, operation: configuration.operation)
    viewController.viewModel.delegate = self
    viewController.navigationItem.title = configuration.operation.name
    navigationController.pushViewController(viewController, animated: animated)
  }
}

// MARK: - OperationEditViewModelDelegate
extension OperationEditCoordinator: OperationEditViewModelDelegate {
  func operationEditViewModelSuccessfullyEditedOperation(_ viewModel: OperationEditViewModel) {
    delegate?.operationEditCoordinatorSuccessfullyEdited(self)
    navigationController.popViewController(animated: true)
  }
}
