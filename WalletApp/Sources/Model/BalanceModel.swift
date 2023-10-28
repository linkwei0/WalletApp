//
//  BalanceModel.swift
//  WalletApp
//

import Foundation

struct BalanceModel {
  var titleBalance: String
  var titleIncome: String
  var titleExpense: String
  var totalBalance: Double
  var totalIncome: Double
  var totalExpense: Double
  var currency: String
}

extension BalanceModel {
  init(titleBalance: String, titleIncome: String, titleExpense: String,
       totalBalance: Decimal, totalIncome: Decimal, totalExpense: Decimal, currency: String) {
    self.titleBalance = titleBalance
    self.titleIncome = titleIncome
    self.titleExpense = titleExpense
    self.totalBalance = NSDecimalNumber(decimal: totalBalance).doubleValue
    self.totalIncome = NSDecimalNumber(decimal: totalIncome).doubleValue
    self.totalExpense = NSDecimalNumber(decimal: totalExpense).doubleValue
    self.currency = currency
  }
}

extension BalanceModel {
  init() {
    titleBalance = ""
    titleIncome = ""
    titleExpense = ""
    totalBalance = 0
    totalIncome = 0
    totalExpense = 0
    currency = CurrencyModelView.WalletsCurrencyType.rub.title
  }
}
