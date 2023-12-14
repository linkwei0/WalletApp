//
//  BudgetPlanningCoordinator.swift
//  WalletApp
//
//  Created by Артём Бацанов on 15.11.2023.
//

import UIKit

struct BudgetPlanningCoordinatorConfiguration {
  let walletID: Int
  let currency: CurrencyModel
}

class BudgetPlanningListCoordinator: ConfigurableCoordinator {
  typealias Configuration = BudgetPlanningCoordinatorConfiguration
  typealias Factory = HasBudgetPlanningFactory
  
  // MARK: - Properties
  var onNeedsToUpdateBudgets: ((BudgetModel) -> Void)?
  
  var childCoordinator: [Coordinator] = []
  var onDidFinish: (() -> Void)?
  
  let navigationController: NavigationController
  let appFactory: AppFactory
  
  private weak var createBudgetNavigation: NavigationController?
  
  private let configuration: Configuration
  private let factory: Factory
  
  // MARK: - Init
  required init(navigationController: NavigationController, appFactory: AppFactory, configuration: Configuration) {
    self.navigationController = navigationController
    self.appFactory = appFactory
    self.configuration = configuration
    self.factory = appFactory
  }
  
  // MARK: - Start
  func start(_ animated: Bool) {
    showBudgetListScreen(animated: animated)
  }
  
  private func showBudgetListScreen(animated: Bool) {
    let viewController = factory.budgetPlanningFactory.makeModule(with: configuration.walletID, currency: configuration.currency)
    viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.plusButton),
                                                                       style: .done, target: self,
                                                                       action: #selector(showCreateBudgetScreen))
    viewController.viewModel.delegate = self
    viewController.viewModel.onNeedsToUpdateRightBarButton = { [weak viewController] isEnabled in
      viewController?.navigationItem.rightBarButtonItem?.isEnabled = isEnabled
    }
    onNeedsToUpdateBudgets = { [weak viewModel = viewController.viewModel] budget in
      viewModel?.updateBudgets(with: budget)
    }
    addPopObserver(for: viewController)
    viewController.title = R.string.walletDetail.budgetPlanningTitle()
    navigationController.pushViewController(viewController, animated: animated)
  }
  
  @objc private func showCreateBudgetScreen() {
    let coordinator = show(CreateBudgetCoordinator.self, configuration: configuration, animated: true)
    coordinator.delegate = self
  }
}

// MARK: - CreateBudgetCoordinatorDelegate
extension BudgetPlanningListCoordinator: CreateBudgetCoordinatorDelegate {
  func coordinatorSuccessfullyCreateBudget(_ coordinator: CreateBudgetCoordinator, budget: BudgetModel) {
    onNeedsToUpdateBudgets?(budget)
  }
}

// MARK: - BudgetPlanningListViewModelDelegate
extension BudgetPlanningListCoordinator: BudgetPlanningListViewModelDelegate {
  func viewModelDidRequestToShowBudgetDetail(_ viewModel: BudgetPlanningListViewModel, budget: BudgetModel) {
    let configuration = BudgetDetailCoordinatorConfiguration(budget: budget, currencyCode: configuration.currency.code)
    show(BudgetDetailCoordinator.self, configuration: configuration, animated: false)
  }
}

private extension Constants {
  static let plusButton = "plus.circle.fill"
}
