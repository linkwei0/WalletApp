//
//  OperationEditCoordinator.swift
//  WalletApp
//
//  Created by Артём Бацанов on 31.10.2023.
//

import UIKit

protocol OperationEditCoordinatorDelegate: AnyObject {
  func operationEditCoordinatorSuccessfullyEdited(_ coordinator: OperationEditCoordinator)
}

struct OperationEditCoordinatorConfiguration {
  let wallet: WalletModel
  let operation: OperationModel
}

class OperationEditCoordinator: NSObject, ConfigurableCoordinator {
  typealias Configuration = OperationEditCoordinatorConfiguration
  typealias Factory = HasOperationEditFactory & HasUseCaseProviderFactory
  
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
    viewController.navigationItem.title = configuration.operation.name
    viewController.viewModel.onDidUpdateOperationCategory = { [weak viewModel = viewController.viewModel] wallet, operation in
      viewController.navigationItem.title = operation.category
      viewModel?.updateOperation(for: wallet, with: operation)
    }
    viewController.viewModel.delegate = self
    addPopObserver(for: viewController)
    navigationController.pushViewController(viewController, animated: animated)
  }
}

// MARK: - OperationEditViewModelDelegate
extension OperationEditCoordinator: OperationEditViewModelDelegate {
  func operationEditViewModelSuccessfullyEditedOperation(_ viewModel: OperationEditViewModel) {
    delegate?.operationEditCoordinatorSuccessfullyEdited(self)
    navigationController.popViewController(animated: true)
  }
  
  func operationEditViewModelDidRequestToShowCategoryScreen(_ viewModel: OperationEditViewModel, wallet: WalletModel,
                                                            operation: OperationModel) {
    let categoryPickerController = factory.operationEditFactory.makeCategoryPicker(wallet, with: operation)
    categoryPickerController.modalPresentationStyle = .overCurrentContext
    categoryPickerController.viewModel.onNeedsToUpdateOperation = { [weak viewModel] wallet, operation in
      viewModel?.onDidUpdateOperationCategory?(wallet, operation)
    }
    navigationController.present(categoryPickerController, animated: false)
  }
}
