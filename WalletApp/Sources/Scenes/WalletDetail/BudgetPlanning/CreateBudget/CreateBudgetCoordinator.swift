//
//  CreateBudgetCoordinator.swift
//  WalletApp
//
//  Created by Артём Бацанов on 15.11.2023.
//

import Foundation

protocol CreateBudgetCoordinatorDelegate: AnyObject {
  func coordinatorSuccessfullyCreateBudget(_ coordinator: CreateBudgetCoordinator)
}

class CreateBudgetCoordinator: ConfigurableCoordinator {
  typealias Configuration = BudgetPlanningCoordinatorConfiguration
  
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
  
  // MARK: - Init
  required init(navigationController: NavigationController, appFactory: AppFactory, configuration: Configuration) {
    self.navigationController = navigationController
    self.appFactory = appFactory
    self.configuration = configuration
  }
  
  // MARK: - Start
  func start(_ animated: Bool) {
    showCreateBudgetScreen(animated: animated)
  }
  
  private func showCreateBudgetScreen(animated: Bool) {
    let localDataSource = LocalDataSource(coreDataStack: CoreDataStack())
    let remoteDataSource = RemoteDataSource()
    let useCaseProvider = UseCaseProvider(localDataSource: localDataSource, remoteDataSource: remoteDataSource)
    let interactor = CreateBudgetInteractor(useCaseProvider: useCaseProvider)
    let viewModel = CreateBudgetViewModel(interactor: interactor, walletID: configuration.walletID)
    viewModel.delegate = self
    let viewController = CreateBudgetViewController(viewModel: viewModel)
    
    let createBudgetNavigation = NavigationController()
    createBudgetNavigation.viewControllers = [viewController]
    createBudgetNavigation.addPopObserver(for: viewController, coordinator: self)
    addPopObserver(for: viewController)
    viewController.navigationItem.title = "Новый бюджет"
    onNeedsToUpdatePeriodBudget = { [weak viewModel] periodType in
      viewModel?.didSelectPeriodOfBudget(periodType: periodType)
    }
    onNeedsToUpdateCategory = { [weak viewModel] expenseType in
      viewModel?.didSelectCategoryOfBudget(expenseType: expenseType)
    }
    self.createBudgetNavigation = createBudgetNavigation
//    addPopObserver(for: createBudgetNavigation)
    navigationController.present(createBudgetNavigation, animated: animated)
  }
}

// MARK: - CreateBudgetViewModelDelegate
extension CreateBudgetCoordinator: CreateBudgetViewModelDelegate {
  func viewModelDidRequestToShowSelectPeriodScreen(_ viewModel: CreateBudgetViewModel) {
    let selectPeriodVM = SelectPeriodViewModel()
    selectPeriodVM.delegate = self
    let selectPeriodVC = SelectPeriodViewController(viewModel: selectPeriodVM)
    selectPeriodVC.navigationItem.title = "Выберите период"
    createBudgetNavigation?.pushViewController(selectPeriodVC, animated: true)
  }
  
  func viewModelDidRequestToShowSelectCategoryScreen(_ viewModel: CreateBudgetViewModel) {
    let selectCategoryVM = SelectCategoryViewModel()
    selectCategoryVM.delegate = self
    let selectCategoryVC = SelectCategoryViewController(viewModel: selectCategoryVM)
    selectCategoryVC.navigationItem.title = "Выберите категорию"
    createBudgetNavigation?.pushViewController(selectCategoryVC, animated: true)
  }
  
  func viewModelSuccessfullyCreateBudget(_ viewModel: CreateBudgetViewModel) {
    createBudgetNavigation?.viewControllers = []
    createBudgetNavigation = nil
    navigationController.dismiss(animated: true)
    delegate?.coordinatorSuccessfullyCreateBudget(self)
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
