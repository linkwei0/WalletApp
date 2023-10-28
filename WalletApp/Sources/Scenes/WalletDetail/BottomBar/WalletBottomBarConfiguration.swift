//
//  BankBottomBarConfiguration.swift
//  WalletApp
//

import Foundation

enum WalletBottomBarConfiguration: String, Codable {
  case walletDetail
  
  var bottomBarItems: [WalletBottomBarItemType] {
    switch self {
    case .walletDetail:
      return [.expense, .income, .profile]
    }
  }
}
