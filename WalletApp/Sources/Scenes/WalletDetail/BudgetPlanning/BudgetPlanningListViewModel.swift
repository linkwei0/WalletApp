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
  
  var onNeedsToUpdateRightBarButton: ((Bool) -> Void)?
  
  var sectionViewModels: [TableSectionViewModel] {
    let cellViewModels = budgets.map { budget in
      let cellViewModel = BudgetCellViewModel(budget, currencyCode: currency.code)
      cellViewModel.delegate = self
      return cellViewModel
    }
    let headerViewModel = BudgetPlanninHeaderViewModel(title: "\(budgets.count)/\(maxBudgetsForWallet)")
    let section = TableSectionViewModel(headerViewModel: headerViewModel)
    section.append(cellViewModels: cellViewModels)
    return [section]
  }
  
  var budgets: [BudgetModel] {
    return viewState.value.currentEntities
  }
    
  private(set) var viewState: Bindable<SimpleViewState<BudgetModel>> = Bindable(.initial)
  
  private let maxBudgetsForWallet: Int = 3
  
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
  
  func updateBudgets() {
    fetchBudgets()
  }
    
  // MARK: - Private methods
  private func fetchBudgets() {
    interactor.getBudgets(for: walletID) { result in
      switch result {
      case .success(let budgets):
        self.viewState.value = self.processResult(budgets)
        self.onNeedsToUpdateRightBarButton?(budgets.count <= self.maxBudgetsForWallet)
      case .failure(let error):
        print("Failed to get budgets with error - \(error)")
      }
    }
  }
}

// MARK: - BudgetCellViewModelDelegate
extension BudgetPlanningListViewModel: BudgetCellViewModelDelegate {
  func cellViewModelDidTap(_ viewModel: BudgetCellViewModel, budget: BudgetModel) {
    delegate?.viewModelDidRequestToShowBudgetDetail(self, budget: budget)
  }
}
