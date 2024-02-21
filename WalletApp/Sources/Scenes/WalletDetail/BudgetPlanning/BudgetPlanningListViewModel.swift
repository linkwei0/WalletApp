//
//  BudgetPlanningViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 15.11.2023.
//

import Foundation

protocol BudgetPlanningListViewModelDelegate: AnyObject {
  func viewModelDidRequestToShowBudgetDetail(_ viewModel: BudgetPlanningListViewModel, budget: BudgetModel)
}

class BudgetPlanningListViewModel: TableViewModel, SimpleViewStateProccessable {
  // MARK: - Properties
  weak var delegate: BudgetPlanningListViewModelDelegate?
  
  var onNeedsToUpdateTableView: (() -> Void)?
  var onNeedsToUpdateRightBarButton: ((Bool) -> Void)?
  var onNeedsToUpdateRowAtTableView: ((IndexPath) -> Void)?
  
  private(set) var sectionViewModels: [TableSectionViewModel] = []
  
  private var budgets: [BudgetModel] = []
  
  private let maxBudgetsForWallet: Int = 3
  private let indexFirstSection: Int = 0
  
  private let interactor: BudgetPlanningListInteractorProtocol
  private let walletID: Int
  private let currency: CurrencyModel
  
  // MARK: - Init
  init(interactor: BudgetPlanningListInteractorProtocol, walletID: Int, currency: CurrencyModel) {
    self.interactor = interactor
    self.walletID = walletID
    self.currency = currency
  }
  
  // MARK: - Public methods
  func viewIsReady() {
    fetchBudgets()
  }
  
  func updateBudgets(with budget: BudgetModel) {
    configureNewCellViewModelAndUpdate(budget)
  }
  
  // MARK: - Private methods
  private func fetchBudgets() {
    interactor.getBudgets(for: walletID) { result in
      switch result {
      case .success(let budgets):
        self.budgets = budgets
        self.onNeedsToUpdateRightBarButton?(budgets.count < self.maxBudgetsForWallet)
        self.configureSectionViewModels(budgets: budgets)
      case .failure(let error):
        print("Failed to get budgets with error - \(error)")
      }
    }
  }
  
  private func configureSectionViewModels(budgets: [BudgetModel]) {
    sectionViewModels.removeAll()
    let cellViewModels = budgets.map { budget in
      let cellViewModel = BudgetCellViewModel(budget, currencyCode: currency.code)
      cellViewModel.delegate = self
      return cellViewModel
    }
    let headerViewModel = BudgetPlanninHeaderViewModel(title: "\(budgets.count)/\(maxBudgetsForWallet)")
    let section = TableSectionViewModel(headerViewModel: headerViewModel)
    if !cellViewModels.isEmpty {
      section.append(cellViewModels: cellViewModels)
      sectionViewModels.append(section)
    }
    onNeedsToUpdateTableView?()
  }
  
  private func configureNewCellViewModelAndUpdate(_ budget: BudgetModel) {
    let cellViewModel = BudgetCellViewModel(budget, currencyCode: currency.code)
    cellViewModel.delegate = self
    sectionViewModels[indexFirstSection].append(cellViewModel)
    let rowIndex = sectionViewModels[indexFirstSection].cellViewModels.count - 1
    let indexPath = IndexPath(row: rowIndex, section: indexFirstSection)
    onNeedsToUpdateRowAtTableView?(indexPath)
  }
  
  private func removeBudget(budget: BudgetModel) {
    interactor.deleteBudget(with: budget.id) { result in
      switch result {
      case .success:
        self.fetchBudgets()
      case .failure(let error):
        print("Failed to delete budget with error \(error)")
      }
    }
  }
}

// MARK: - BudgetCellViewModelDelegate
extension BudgetPlanningListViewModel: BudgetCellViewModelDelegate {
  func cellViewModelDidTap(_ viewModel: BudgetCellViewModel, budget: BudgetModel) {
    delegate?.viewModelDidRequestToShowBudgetDetail(self, budget: budget)
  }
  
  func cellViewMdodelDidRequestToDeleteBudget(_ viewModel: BudgetCellViewModel, budget: BudgetModel) {
    removeBudget(budget: budget)
  }
}
