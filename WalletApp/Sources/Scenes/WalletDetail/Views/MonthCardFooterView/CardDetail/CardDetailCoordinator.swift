//
//  CardDetailCoordinator.swift
//  WalletApp
//
//  Created by Артём Бацанов on 15.12.2023.
//

import Foundation

struct CardDetailCoordinatorConfiguration {
  let categoryName: String
  let operations: [OperationModel]
}

class CardDetailCoordinator: ConfigurableCoordinator {
  typealias Configuration = CardDetailCoordinatorConfiguration
  
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
    showCardDetailScreen(animated: animated)
  }
  
  private func showCardDetailScreen(animated: Bool) {
    let viewModel = CardDetailViewModel(categoryName: configuration.categoryName, operations: configuration.operations)
    viewModel.delegate = self
    let viewController = CardDetailViewController(viewModel: viewModel)
    viewController.modalPresentationStyle = .overCurrentContext
    navigationController.present(viewController, animated: animated)
  }
}

// MARK: - CardDetailViewModelDelegate
extension CardDetailCoordinator: CardDetailViewModelDelegate {
  func cardDetailViewModelDidRequestToDismiss(_ viewModel: CardDetailViewModel) {
    navigationController.dismiss(animated: false)
    onDidFinish?()
  }
}
