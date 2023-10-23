//
//  CDWallet.swift
//  WalletApp
//
//  Created by Артём Бацанов on 12.10.2023.
//

import Foundation

extension CDWallet: Persistent {
  func makeDomain() -> WalletModel? {
    guard let name = name, let currency = currency, let balance = balance?.decimalValue,
          let totalSpent = totalSpent?.decimalValue, let totalEarned = totalEarned?.decimalValue else { return nil }
    return WalletModel(id: Int(id), name: name, currency: currency, balance: balance,
                       totalSpent: totalSpent, totalEarned: totalEarned)
  }
}