//
//  SelectCategoryViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 21.11.2023.
//

import Foundation

protocol SelectCategoryViewModelDelegate: AnyObject {
  func viewModelSuccessfullySelectedCategory(_ viewModel: SelectCategoryViewModel, expenseCategory: ExpenseCategoryTypes)
}

class SelectCategoryViewModel {
  // MARK: - Properties
  weak var delegate: SelectCategoryViewModelDelegate?
  
  var cellViewModels: [SelectCategoryCellViewModelProtocol] {
    return expenseCategoryTypes.map { SelectCategoryCellViewModel($0) }
  }
  
  private let expenseCategoryTypes: [ExpenseCategoryTypes] = ExpenseCategoryTypes.allCases
  
  // MARK: - Public methods
  func didSelectRow(at indexPath: IndexPath) {
    let expenseCategory = expenseCategoryTypes[indexPath.row]
    delegate?.viewModelSuccessfullySelectedCategory(self, expenseCategory: expenseCategory)
  }
}
