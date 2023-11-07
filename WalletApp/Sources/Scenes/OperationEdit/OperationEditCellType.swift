//
//  OperationEditCellType.swift
//  WalletApp
//
//  Created by Артём Бацанов on 31.10.2023.
//

import Foundation

enum OperationEditCellType {
  case category, amount, info
  
  var placeholderContentTextField: String {
    switch self {
    case .amount:
      return "Общее значение операции"
    default:
      return ""
    }
  }
  
  var isHiddenOperationCategoryButton: Bool {
    switch self {
    case .category:
      return false
    default:
      return true
    }
  }
  
  var isHiddenContentTextField: Bool {
    switch self {
    case .amount:
      return false
    default:
      return true
    }
  }
  
  var isHiddenMoreInfoTextView: Bool {
    switch self {
    case .info:
      return false
    default:
      return true
    }
  }
  
  var isHiddenCurrencyLabel: Bool {
    switch self {
    case .amount:
      return false
    default:
      return true
    }
  }
  
  var isHiddenMaxCharsLabel: Bool {
    switch self {
    case .info:
      return false
    default:
      return true
    }
  }
  
  var isHiddenCategoryImageView: Bool {
    switch self {
    case .category:
      return false
    default:
      return true
    }
  }
}
