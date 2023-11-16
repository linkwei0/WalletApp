//
//  BudgetPlanningCoordinator.swift
//  WalletApp
//
//  Created by Артём Бацанов on 15.11.2023.
//

import UIKit

class BudgetPlanningListCoordinator: Coordinator {
  var childCoordinator: [Coordinator] = []
  var onDidFinish: (() -> Void)?
  
  let navigationController: NavigationController
  let appFactory: AppFactory
  
  required init(navigationController: NavigationController, appFactory: AppFactory) {
    self.navigationController = navigationController
    self.appFactory = appFactory
  }
  
  func start(_ animated: Bool) {
    showBudgetListScreen(animated: animated)
  }
  
  private func showBudgetListScreen(animated: Bool) {
    let viewModel = BudgetPlanningListViewModel()
    let viewController = BudgetPlanningListViewController(viewModel: viewModel)
    viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"),
                                                                       style: .done, target: self,
                                                                       action: #selector(showCreateBudgetScreen))
    addPopObserver(for: viewController)
    viewController.title = "Планирование бюджета"
    navigationController.pushViewController(viewController, animated: animated)
  }
  
  @objc private func showCreateBudgetScreen() {
    show(CreateBudgetCoordinator.self, animated: true)
  }
}
