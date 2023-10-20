//
//  BalanceModel.swift
//  WalletApp
//

import Foundation

struct BalanceModel {
  var totalBalance: Int
  var totalIncome: Int
  var totalExpense: Int
}

extension BalanceModel {
  init() {
    totalBalance = 0
    totalIncome = 0
    totalExpense = 0
  }
}
