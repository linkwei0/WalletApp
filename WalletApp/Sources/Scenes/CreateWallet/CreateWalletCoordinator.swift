//
//  CreateWalletCoordinator.swift
//  WalletApp
//

import UIKit

protocol CreateWalletCoordinatorDelegate: AnyObject {
  func createWalletCoordinatorSuccessfullyCreatedWallet(_ coordinator: CreateWalletCoordinator)
}

struct CurrencyRates {
  let usd: Decimal
  let euro: Decimal
}

struct CreateWalletCoordinatorConfiguration {
  let rates: CurrencyRates
}

class CreateWalletCoordinator: ConfigurableCoordinator {
  // MARK: - Properties
  typealias Configuration = CreateWalletCoordinatorConfiguration
  typealias Factory = HasCreateWalletFactory
  
  weak var delegate: CreateWalletCoordinatorDelegate?
  
  var childCoordinator: [Coordinator] = []
  var onDidFinish: (() -> Void)?
  
  let navigationController: NavigationController
  let appFactory: AppFactory
  
  private let factory: Factory
  private let configuration: Configuration

  required init(navigationController: NavigationController, appFactory: AppFactory, configuration: Configuration) {
    self.navigationController = navigationController
    self.appFactory = appFactory
    self.factory = appFactory
    self.configuration = configuration
  }
  
  func start(_ animated: Bool) {
    showCreateWalletScreen(animated: animated)
  }
  
  private func showCreateWalletScreen(animated: Bool) {
    let createWalletVC = factory.createWalletFactory.makeModule(with: configuration.rates)
    createWalletVC.viewModel.delegate = self
    navigationController.addPopObserver(for: createWalletVC, coordinator: self)
    createWalletVC.title = "Новый кошелек"
    navigationController.pushViewController(createWalletVC, animated: animated)
  }
}

// MARK: - CreateWalletViewModelDelegate
extension CreateWalletCoordinator: CreateWalletViewModelDelegate {
  func viewModelDidRequestToWalletsScreen(_ viewModel: CreateWalletViewModel, wallet: WalletModel) {
    delegate?.createWalletCoordinatorSuccessfullyCreatedWallet(self)
    navigationController.popToRootViewController(animated: true)
  }
}
