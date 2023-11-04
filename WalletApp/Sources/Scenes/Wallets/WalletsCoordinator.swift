//
//  WalletsCoordinator.swift
//  WalletApp
//

import UIKit

final class WalletsCoordinator: Coordinator {
  // MARK: - Properties
  typealias Factory = HasWalletsFactory

  var childCoordinator: [Coordinator] = []
  var onDidFinish: (() -> Void)?
  
  let navigationController: NavigationController
  let appFactory: AppFactory
  
  private var onNeedsToUpdateWallets: (() -> Void)?
  
  private let factory: Factory
    
  // MARK: - Init
  
  required init(navigationController: NavigationController, appFactory: AppFactory) {
    self.navigationController = navigationController
    self.appFactory = appFactory
    self.factory = appFactory
  }
  
  // MARK: - Start
  
  func start(_ animated: Bool) {
    showWalletsScreen(animated: animated)
  }
  
  private func showWalletsScreen(animated: Bool) {    
    let walletsVC = factory.walletsFactory.makeModule()
    onNeedsToUpdateWallets = { [weak viewModel = walletsVC.viewModel] in
      viewModel?.updateWallets()
      
    }
    walletsVC.viewModel.delegate = self
    addPopObserver(for: walletsVC)
    navigationController.pushViewController(walletsVC, animated: animated)
  }
}

// MARK: - WalletsViewModelDelegate
extension WalletsCoordinator: WalletsViewModelDelegate {
  func walletsViewModelDidRequestToShowWalletDetail(_ viewModel: WalletsViewModel, wallet: WalletModel) {
    let configuration = WalletDetailCoordinatorConfiguration(wallet: wallet)
    let coordinator = show(WalletDetailCoordinator.self, configuration: configuration, animated: true)
    coordinator.delegate = self
  }
  
  func walletsViewModelDidRequestToShowAddNewWallet(_ viewModel: WalletsViewModel, currencyRates: CurrencyRates) {
    let configuration = CreateWalletCoordinatorConfiguration(rates: currencyRates)
    let coordinator = show(CreateWalletCoordinator.self, configuration: configuration, animated: true)
    coordinator.delegate = self
  }
}

// MARK: - CreateWalletCoordinatorDelegate
extension WalletsCoordinator: CreateWalletCoordinatorDelegate {
  func createWalletCoordinatorSuccessfullyCreatedWallet(_ coordinator: CreateWalletCoordinator) {
    onNeedsToUpdateWallets?()
  }
}

// MARK: - WalletDetaiCoordinatorDelegate
extension WalletsCoordinator: WalletDetaiCoordinatorDelegate {
  func walletDetailCoordinatorSuccessfullyUpdatedOperation(_ coordinator: WalletDetailCoordinator) {
    onNeedsToUpdateWallets?()
  }
}
