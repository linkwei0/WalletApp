//
//  CreateBudgetCellViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 16.11.2023.
//

import Foundation

//protocol CreateBudgetCellViewModelProtocol {
//  var isHiddenContainer: Bool { get }
//  var title: String { get }
//  var budgetAmount: Bindable<String> { get }
//}

protocol CreateBudgetCellViewModelDelegate: AnyObject {
  func cellViewModelDidRequestToShowModalBottomView(_ viewModel: CreateBudgetCellViewModel)
}

class CreateBudgetCellViewModel {
  weak var delegate: CreateBudgetCellViewModelDelegate?
  
  var isHiddenContainer: Bool {
    return type.isAmountContainerView
  }
  
  var title: String {
    return type.text
  }
  
  var amount: String? {
    return budgetAmount
  }
  
  private let type: CreateBudgetCellType
  private let budgetAmount: String
  
  init(_ type: CreateBudgetCellType, budgetAmountArr: [String]? = nil) {
    self.type = type
    self.budgetAmount = budgetAmountArr?.joined() ?? "0"
  }
  
  func select() {
    switch type {
    case .amount:
      delegate?.cellViewModelDidRequestToShowModalBottomView(self)
    case .period:
      print("period")
    case .name:
      print("name")
    case .category:
      print("category")
    }
  }
}

// MARK: - TableCellViewModel
extension CreateBudgetCellViewModel: TableCellViewModel {
  var tableReuseIdentifier: String {
    return CreateBudgetCell.reuseIdentifiable
  }
}
