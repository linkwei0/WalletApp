//
//  BankBottomBarConfiguration.swift
//  WalletApp
//

import Foundation

enum BankBottomBarConfiguration: String, Codable {
  case walletDetail
  
  var bottomBarItems: [BankBottomBarItemType] {
    switch self {
    case .walletDetail:
      return [.expense, .income, .profile]
    }
  }
}
