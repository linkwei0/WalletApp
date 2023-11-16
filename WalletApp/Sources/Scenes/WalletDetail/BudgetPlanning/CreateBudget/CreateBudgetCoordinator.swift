//
//  CreateBudgetCoordinator.swift
//  WalletApp
//
//  Created by Артём Бацанов on 15.11.2023.
//

import Foundation

class CreateBudgetCoordinator: Coordinator {
  var childCoordinator: [Coordinator] = []
  var onDidFinish: (() -> Void)?
  
  let navigationController: NavigationController
  let appFactory: AppFactory
  
  required init(navigationController: NavigationController, appFactory: AppFactory) {
    self.navigationController = navigationController
    self.appFactory = appFactory
  }
  
  func start(_ animated: Bool) {
    showCreateBudgetScreen(animated: animated)
  }
  
  private func showCreateBudgetScreen(animated: Bool) {
    let viewModel = CreateBudgetViewModel()
    let viewController = CreateBudgetViewController(viewModel: viewModel)
    let navVC = NavigationController()
    navVC.viewControllers = [viewController]
    addPopObserver(for: navVC)
    viewController.navigationItem.title = "Новый бюджет"
    navigationController.present(navVC, animated: animated)
  }
}
