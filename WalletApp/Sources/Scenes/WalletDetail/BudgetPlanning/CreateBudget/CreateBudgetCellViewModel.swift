//
//  CreateBudgetCellViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 16.11.2023.
//

import Foundation

protocol CreateBudgetCellViewModelDelegate: AnyObject {
  func cellViewModelDidRequestToShowModalBottomView(_ viewModel: CreateBudgetCellViewModel)
  func cellViewModelDidRequestToSelectPeriodScreen(_ viewModel: CreateBudgetCellViewModel)
  func cellViewModelDidRequestToSelectCategoryScreen(_ viewModel: CreateBudgetCellViewModel)
  func cellViewModelDidRequestToUpdateName(_ viewModel: CreateBudgetCellViewModel, with text: String)
}

class CreateBudgetCellViewModel {
  // MARK: - Properties
  weak var delegate: CreateBudgetCellViewModelDelegate?
  
  var isHiddenContainer: Bool {
    return type.isAmountContainer
  }
  
  var hiddenTextField: Bool {
    return !type.isTextField
  }
  
  var amount: String? {
    return budgetAmount.isFractional ? budgetAmount : budgetAmount.makeSpaces()
  }
  
  var title: String? {
    if type.isCategory {
      return categoryText
    }
    if type.isPeriod {
      return periodBudgetText
    }
    return type.placeholderText
  }
    
  var categoryText: String? {
    return categoryType != nil ? categoryType?.title : type.placeholderText
  }
  
  var periodBudgetText: String? {
    return periodType != nil ? periodType?.title : type.placeholderText
  }
  
  private let type: CreateBudgetCellTypes
  private let budgetAmount: String
  private let periodType: SelectPeriodTypes?
  private let categoryType: ExpenseCategoryTypes?
  
  // MARK: - Init
  init(_ type: CreateBudgetCellTypes,
       budgetAmountArr: [String]? = nil,
       periodType: SelectPeriodTypes? = nil, 
       categoryType: ExpenseCategoryTypes? = nil) {
    self.type = type
    self.budgetAmount = budgetAmountArr?.joined() ?? "0"
    self.periodType = periodType
    self.categoryType = categoryType
  }
  
  // MARK: - Public methods
  func select() {
    switch type {
    case .amount:
      delegate?.cellViewModelDidRequestToShowModalBottomView(self)
    case .period:
      delegate?.cellViewModelDidRequestToSelectPeriodScreen(self)
    case .name:
      break
    case .category:
      delegate?.cellViewModelDidRequestToSelectCategoryScreen(self)
    }
  }
  
  func changeTextField(_ text: String) {
    if !text.isEmpty {
      delegate?.cellViewModelDidRequestToUpdateName(self, with: text)
    }
  }
}

// MARK: - TableCellViewModel
extension CreateBudgetCellViewModel: TableCellViewModel {
  var tableReuseIdentifier: String {
    return CreateBudgetCell.reuseIdentifiable
  }
}
