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
    walletsVC.viewModel.delegate = self
    addPopObserver(for: walletsVC)
    navigationController.pushViewController(walletsVC, animated: animated)
  }
}

extension WalletsCoordinator: WalletsViewModelDelegate {
  func walletsViewModelDidRequestToShowWalletDetail(_ viewModel: WalletsViewModel, wallet: WalletModel) {
    let configuration = WalletDetailCoordinatorConfiguration(wallet: wallet)
    show(WalletDetailCoordinator.self, configuration: configuration, animated: true)
  }
  
  func walletsViewModelDidRequestToShowAddNewWallet(_ viewModel: WalletsViewModel) {
    show(CreateWalletCoordinator.self, animated: true)
  }
}
