//
//  MainCoordinator.swift
//  WalletApp
//

import UIKit

final class MainCoordinator: Coordinator {
  var childCoordinator: [Coordinator] = []
  var onDidFinish: (() -> Void)?
  
  let navigationController: NavigationController
  let appFactory: AppFactory
  
  required init(navigationController: NavigationController, appFactory: AppFactory = AppFactory()) {
    self.navigationController = navigationController
    self.appFactory = appFactory
  }
  
  func start(_ animated: Bool) {
    showWalletsScreen(animated: animated)
  }
  
  private func showWalletsScreen(animated: Bool) {
    show(WalletsCoordinator.self, animated: animated)
  }
}
