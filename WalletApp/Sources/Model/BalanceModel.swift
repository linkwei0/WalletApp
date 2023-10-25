//
//  BalanceModel.swift
//  WalletApp
//

import Foundation

struct BalanceModel {
  var totalBalance: Double
  var totalIncome: Double
  var totalExpense: Double
  
  init(totalBalance: Decimal, totalIncome: Decimal, totalExpense: Decimal) {
    self.totalBalance = NSDecimalNumber(decimal: totalBalance).doubleValue
    self.totalIncome = NSDecimalNumber(decimal: totalIncome).doubleValue
    self.totalExpense = NSDecimalNumber(decimal: totalExpense).doubleValue
  }
}

extension BalanceModel {
  init() {
    totalBalance = 0
    totalIncome = 0
    totalExpense = 0
  }
}
