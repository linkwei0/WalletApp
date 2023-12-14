//
//  CreateBudgetCoordinator.swift
//  WalletApp
//
//  Created by Артём Бацанов on 15.11.2023.
//

import Foundation

protocol CreateBudgetCoordinatorDelegate: AnyObject {
  func coordinatorSuccessfullyCreateBudget(_ coordinator: CreateBudgetCoordinator, budget: BudgetModel)
}

class CreateBudgetCoordinator: ConfigurableCoordinator {
  typealias Configuration = BudgetPlanningCoordinatorConfiguration
  typealias Factory = HasCreateBudgetFactory
  
  // MARK: - Properties
  weak var delegate: CreateBudgetCoordinatorDelegate?
  
  var onNeedsToUpdatePeriodBudget: ((SelectPeriodTypes) -> Void)?
  var onNeedsToUpdateCategory: ((ExpenseCategoryTypes) -> Void)?
  
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
    showCreateBudgetScreen(animated: animated)
  }
  
  private func showCreateBudgetScreen(animated: Bool) {
    let viewController = factory.createBudgetFactory.makeModule(with: configuration.walletID)
    viewController.viewModel.delegate = self
    viewController.navigationItem.title = R.string.walletDetail.createBudgetTitle()
    
    let createBudgetNavigation = NavigationController()
    createBudgetNavigation.addPopObserver(for: viewController, coordinator: self)
    createBudgetNavigation.pushViewController(viewController, animated: false)
    
    onNeedsToUpdatePeriodBudget = { [weak viewModel = viewController.viewModel] periodType in
      viewModel?.didSelectPeriodOfBudget(periodType: periodType)
    }
    onNeedsToUpdateCategory = { [weak viewModel = viewController.viewModel] expenseType in
      viewModel?.didSelectCategoryOfBudget(expenseType: expenseType)
    }
    
    self.createBudgetNavigation = createBudgetNavigation
    navigationController.present(createBudgetNavigation, animated: animated)
  }
}

// MARK: - CreateBudgetViewModelDelegate
extension CreateBudgetCoordinator: CreateBudgetViewModelDelegate {
  func viewModelDidRequestToShowSelectPeriodScreen(_ viewModel: CreateBudgetViewModel) {
    let selectPeriodVC = factory.createBudgetFactory.makePeriodModule()
    selectPeriodVC.viewModel.delegate = self
    selectPeriodVC.navigationItem.title = R.string.walletDetail.createBudgetSelectPeriodTitle()
    createBudgetNavigation?.pushViewController(selectPeriodVC, animated: true)
  }
  
  func viewModelDidRequestToShowSelectCategoryScreen(_ viewModel: CreateBudgetViewModel) {
    let selectCategoryVC = factory.createBudgetFactory.makeCategoryModule()
    selectCategoryVC.viewModel.delegate = self
    selectCategoryVC.navigationItem.title = R.string.walletDetail.createBudgetSelectCategoryTitle()
    createBudgetNavigation?.pushViewController(selectCategoryVC, animated: true)
  }
  
  func viewModelSuccessfullyCreateBudget(_ viewModel: CreateBudgetViewModel, budget: BudgetModel) {
    navigationController.dismiss(animated: true)
    delegate?.coordinatorSuccessfullyCreateBudget(self, budget: budget)
    onDidFinish?()
  }
  
  func viewModelDidRequestToDismiss(_ viewModel: CreateBudgetViewModel) {
    navigationController.dismiss(animated: false)
    onDidFinish?()
  }
}

// MARK: - SelectPeriodViewModelDelegate
extension CreateBudgetCoordinator: SelectPeriodViewModelDelegate {
  func viewModelSuccessfullySelectedPeriod(_ viewModel: SelectPeriodViewModel, periodType: SelectPeriodTypes) {
    onNeedsToUpdatePeriodBudget?(periodType)
    createBudgetNavigation?.popToRootViewController(animated: true)
  }
}

// MARK: SelectCategoryViewModelDelegate
extension CreateBudgetCoordinator: SelectCategoryViewModelDelegate {
  func viewModelSuccessfullySelectedCategory(_ viewModel: SelectCategoryViewModel, expenseCategory: ExpenseCategoryTypes) {
    onNeedsToUpdateCategory?(expenseCategory)
    createBudgetNavigation?.popToRootViewController(animated: true)
  }
}
