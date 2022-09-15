//
//  IncomeCoordinator.swift
//  WalletApp
//

import UIKit

class IncomeCoordinator: Coordinator {
  var childCoordinator: [Coordinator] = []
  var onDidFinish: (() -> Void)?
  
  let navigationController: UINavigationController
  let appDependency: AppDependency
  
  required init(navigationController: UINavigationController, appDependency: AppDependency) {
    self.navigationController = navigationController
    self.appDependency = appDependency
  }
  
  func start(_ animated: Bool) {
    showIncomeScreen(animated: animated)
  }
  
  private func showIncomeScreen(animated: Bool) {
    let incomeVC = IncomeViewController()
    navigationController.pushViewController(incomeVC, animated: animated)
  }
}
