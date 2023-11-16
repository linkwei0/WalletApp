//
//  CreateBudgetCellViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 16.11.2023.
//

import Foundation

protocol CreateBudgetCellViewModelProtocol {
  var isHiddenContainer: Bool { get }
  var title: String { get }
}

class CreateBudgetCellViewModel: CreateBudgetCellViewModelProtocol {
  var isHiddenContainer: Bool {
    return type.isAmountContainerView
  }
  
  var title: String {
    return type.text
  }
  
  private let type: CreateBudgetCellType
  
  init(_ type: CreateBudgetCellType) {
    self.type = type
  }
}
