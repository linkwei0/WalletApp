//
//  CreateBudgetViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 15.11.2023.
//

import Foundation

enum CreateBudgetCellType: CaseIterable {
  case amount, period, name, category
    
  var text: String {
    switch self {
    case .amount:
      return ""
    case .period:
      return "Выберите период"
    case .name:
      return "Введите название"
    case .category:
      return "Выберите категорию"
    }
  }
  
  var isAmountContainerView: Bool {
    switch self {
    case .amount:
      return true
    case .period, .name, .category:
      return false
    }
  }
}

class CreateBudgetViewModel {
  // MARK: - Properties
  var onNeedsUpdate: (() -> Void)?
  var onNeedsShowCalculationModalView: (() -> Void)?
  
  var cellViewModels: [CreateBudgetCellViewModelProtocol] {
    return budgetCellTypes.map { CreateBudgetCellViewModel($0) }
  }
  
  private let budgetCellTypes: [CreateBudgetCellType] = CreateBudgetCellType.allCases
  
  // MARK: - Public methods
  func viewIsReady() {
    onNeedsUpdate?()
  }
  
  func didSelect(at indexPath: IndexPath) {
    let cellType = budgetCellTypes[indexPath.row]
    switch cellType {
    case .amount:
      onNeedsShowCalculationModalView?()
    case .period, .name, .category:
      print("TODO it!")
    }
  }
}
