//
//  BalanceModel.swift
//  WalletApp
//

import Foundation

struct BalanceModel {
  var titleBalance: String
  var titleIncome: String
  var titleExpense: String
  var totalBalance: String
  var totalIncome: String
  var totalExpense: String
  var currency: String
}

extension BalanceModel {
  static func makeCleanModel() -> BalanceModel {
    return BalanceModel(titleBalance: "", titleIncome: "", titleExpense: "",
                        totalBalance: "0", totalIncome: "0", totalExpense: "0",
                        currency: CurrencyModelView.WalletsCurrencyType.rub.title)
  }
}
