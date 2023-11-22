//
//  BudgetPlanningCoordinator.swift
//  WalletApp
//
//  Created by Артём Бацанов on 15.11.2023.
//

import UIKit

struct BudgetPlanningCoordinatorConfiguration {
  let walletID: Int
}

class BudgetPlanningListCoordinator: ConfigurableCoordinator {
  typealias Configuration = BudgetPlanningCoordinatorConfiguration
  
  // MARK: - Properties
  var onNeedsToUpdateBudgets: (() -> Void)?
  
  var childCoordinator: [Coordinator] = []
  var onDidFinish: (() -> Void)?
  
  let navigationController: NavigationController
  let appFactory: AppFactory
  
  private let configuration: Configuration
  
  // MARK: - Init
  required init(navigationController: NavigationController, appFactory: AppFactory, configuration: Configuration) {
    self.navigationController = navigationController
    self.appFactory = appFactory
    self.configuration = configuration
  }
  
  // MARK: - Start
  func start(_ animated: Bool) {
    showBudgetListScreen(animated: animated)
  }
  
  private func showBudgetListScreen(animated: Bool) {
    let remoteDataSource = RemoteDataSource()
    let localDataSource = LocalDataSource(coreDataStack: CoreDataStack())
    let useCase = UseCaseProvider(localDataSource: localDataSource, remoteDataSource: remoteDataSource)
    let interactor = BudgetPlanningListInteractor(useCaseProvider: useCase)
    let viewModel = BudgetPlanningListViewModel(interactor: interactor, walletID: configuration.walletID)
    let viewController = BudgetPlanningListViewController(viewModel: viewModel)
    viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"),
                                                                       style: .done, target: self,
                                                                       action: #selector(showCreateBudgetScreen))
    onNeedsToUpdateBudgets = { [weak viewModel] in
      viewModel?.updateBudgets()
    }
    addPopObserver(for: viewController)
    viewController.title = "Планирование бюджета"
    navigationController.pushViewController(viewController, animated: animated)
  }
  
  @objc private func showCreateBudgetScreen() {
    let coordinator = show(CreateBudgetCoordinator.self, configuration: configuration, animated: true)
    coordinator.delegate = self
  }
}

// MARK: - CreateBudgetCoordinatorDelegate
extension BudgetPlanningListCoordinator: CreateBudgetCoordinatorDelegate {
  func coordinatorSuccessfullyCreateBudget(_ coordinator: CreateBudgetCoordinator) {
    onNeedsToUpdateBudgets?()
  }
}
