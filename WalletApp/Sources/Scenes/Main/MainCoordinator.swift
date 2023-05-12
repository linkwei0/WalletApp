//
//  MainCoordinator.swift
//  WalletApp
//

import UIKit

class MainCoordinator: Coordinator {
  var childCoordinator: [Coordinator] = []
  var onDidFinish: (() -> Void)?
  
  let navigationController: UINavigationController
  let appDependency: AppDependency
  
  required init(navigationController: UINavigationController, appDependency: AppDependency = AppDependency()) {
    self.navigationController = navigationController
    self.appDependency = appDependency
  }
  
  func start(_ animated: Bool) {
    showBankScreen(animated: animated)
  }
  
  private func showBankScreen(animated: Bool) {
    show(BankCoordinator.self, animated: animated)
  }
}
