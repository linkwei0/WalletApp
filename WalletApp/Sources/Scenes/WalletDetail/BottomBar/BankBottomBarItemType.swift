//
//  BankBottomBarItemType.swift
//  WalletApp
//

import UIKit

enum BankBottomBarItemType: CaseIterable {
  case income, expense, profile
  
  var title: String {
    switch self {
    case .income:
      return R.string.bank.bankBottomBarExpenseTitle()
    case .expense:
      return R.string.bank.bankBottomBarIncomeTitle()
    case .profile:
      return R.string.bank.bankBottomBarProfileTitle()
    }
  }
  
  var icon: UIImage? {
    switch self {
    case .income:
      return UIImage(systemName: "plus.circle")
    case .expense:
      return UIImage(systemName: "minus.circle")
    case .profile:
      return UIImage(systemName: "person.crop.circle.fill")
    }
  }
  
  var color: UIColor {
    switch self {
    case .expense:
      return .expenseBtnColor
    case .income:
      return .incomeBtnColor
    case .profile:
      return .baseWhite
    }
  }
  
  var highlightColor: UIColor {
    switch self {
    default:
      return .baseWhite
    }
  }
}
