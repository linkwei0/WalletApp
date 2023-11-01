//
//  BankBottomBarItemType.swift
//  WalletApp
//

import UIKit

enum WalletBottomBarItemType: CaseIterable {
  case income, expense, profile
  
  var title: String {
    switch self {
    case .income:
      return R.string.wallet.walletDetailBottomBarIncomeTitle()
    case .expense:
      return R.string.wallet.walletDetailBottomBarExpenseTitle()
    case .profile:
      return R.string.wallet.walletDetailBottomBarProfileTitle()
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
