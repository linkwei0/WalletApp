//
//  CreateWalletCoordinator.swift
//  WalletApp
//

import UIKit

class CreateWalletCoordinator: Coordinator {
  // MARK: - Properties
  typealias Factory = HasCreateWalletFactory
  
  var childCoordinator: [Coordinator] = []
  var onDidFinish: (() -> Void)?
  
  let navigationController: NavigationController
  let appFactory: AppFactory
  
  private let factory: Factory

  required init(navigationController: NavigationController, appFactory: AppFactory) {
    self.navigationController = navigationController
    self.appFactory = appFactory
    self.factory = appFactory
  }
  
  func start(_ animated: Bool) {
    showCreateWalletScreen(animated: animated)
  }
  
  private func showCreateWalletScreen(animated: Bool) {
    let createWalletVC = factory.createWalletFactory.makeModule()
    createWalletVC.viewModel.delegate = self
    navigationController.addPopObserver(for: createWalletVC, coordinator: self)
    createWalletVC.title = "Новый кошелек"
    navigationController.pushViewController(createWalletVC, animated: animated)
  }
}

// MARK: - CreateWalletViewModelDelegate
extension CreateWalletCoordinator: CreateWalletViewModelDelegate {
  func viewModelDidRequestToWalletsScreen(_ viewModel: CreateWalletViewModel, wallet: WalletModel) {
    navigationController.popToRootViewController(animated: true)
  }
}
