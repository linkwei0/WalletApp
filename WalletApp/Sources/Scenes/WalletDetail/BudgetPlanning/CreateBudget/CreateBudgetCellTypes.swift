//
//  CreateBudgetCellTypes.swift
//  WalletApp
//
//  Created by Артём Бацанов on 21.11.2023.
//

import Foundation

enum CreateBudgetCellTypes: CaseIterable {
  case amount, period, name, category
  
  var placeholderText: String {
    switch self {
    case .amount, .name:
      return ""
    case .period:
      return R.string.walletDetail.createBudgetCellTypesPeriodTitle()
    case .category:
      return R.string.walletDetail.createBudgetCellTypesCategoryTitle()
    }
  }
  
  var isTextField: Bool {
    switch self {
    case .amount, .period, .category:
      return false
    case .name:
      return true
    }
  }
  
  var isCategory: Bool {
    switch self {
    case .category:
      return true
    default:
      return false
    }
  }
  
  var isPeriod: Bool {
    switch self {
    case .period:
      return true
    default:
      return false
    }
  }
  
  var isAmountContainer: Bool {
    switch self {
    case .amount:
      return true
    case .period, .name, .category:
      return false
    }
  }
}
