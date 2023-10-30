//
//  OperationType.swift
//  WalletApp
//

import Foundation

enum OperationType: String {
  case income
  case expense
  
  var titleType: String {
    switch self {
    case .income:
      return "Доход"
    case .expense:
      return "Расход"
    }
  }
  
  var isIncome: Bool {
    switch self {
    case .income:
      return true
    case .expense:
      return false
    }
  }
}
