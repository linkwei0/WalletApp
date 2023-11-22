//
//  BudgetPlanningViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 15.11.2023.
//

import Foundation

class BudgetPlanningListViewModel: TableViewModel, SimpleViewStateProccessable {
  // MARK: - Properties
  var sectionViewModels: [TableSectionViewModel] {
    let cellViewModels = budgets.map { BudgetCellViewModel($0) }
    let section = TableSectionViewModel()
    section.append(cellViewModels: cellViewModels)
    return [section]
  }
  
  var budgets: [BudgetModel] {
    return viewState.value.currentEntities
  }
  
  private(set) var viewState: Bindable<SimpleViewState<BudgetModel>> = Bindable(.initial)
  
  private let interactor: BudgetPlanningListInteractorProtocol
  private let walletID: Int
  
  // MARK: - Init
  init(interactor: BudgetPlanningListInteractorProtocol, walletID: Int) {
    self.interactor = interactor
    self.walletID = walletID
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
      case .failure(let error):
        print("Failed to get budgets with error - \(error)")
      }
    }
  }
}
