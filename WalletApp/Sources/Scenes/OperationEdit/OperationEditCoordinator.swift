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
  
  weak var delegate: OperationEditCoordinatorDelegate?
  
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
    showOperationEditScreen(animated: animated)
  }
  
  private func showOperationEditScreen(animated: Bool) {
    let remote = RemoteDataSource()
    let local = LocalDataSource(coreDataStack: CoreDataStack())
    let useCase = UseCaseProvider(localDataSource: local, remoteDataSource: remote)
    let interactor = OperationEditInteractor(useCaseProvider: useCase)
    let viewModel = OperationEditViewModel(interactor: interactor, wallet: configuration.wallet,
                                           operation: configuration.operation)
    viewModel.delegate = self
    let viewController = OperationEditViewController(viewModel: viewModel)
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
