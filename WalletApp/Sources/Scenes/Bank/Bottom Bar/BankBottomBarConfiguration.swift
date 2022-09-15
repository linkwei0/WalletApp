//
//  BankBottomBarConfiguration.swift
//  WalletApp
//

import Foundation

enum BankBottomBarConfiguration: String, Codable {
  case main
  
  var bottomBarItems: [BankBottomBarItemType] {
    switch self {
    case .main:
      return [.expense, .income, .profile]
    }
  }
}
