//
//  BalanceViewViewModel.swift
//  WalletApp
//

import Foundation

class BalanceViewModel {
  private(set) var balance: Bindable<BalanceModel> = Bindable(BalanceModel())
  
  // MARK: - Public methods
  func updateBalance(titleBalance: String, titleIncome: String, titleExpense: String,
                     totalBalance: Decimal, totalIncome: Decimal, totalExpense: Decimal,
                     currencyCode: String) {
    let currency = CurrencyModelView.WalletsCurrencyType(rawValue: currencyCode) ?? .rub
    let roundedTotalBalance = round(NSDecimalNumber(decimal: totalBalance).doubleValue * 100) / 100.0
    let roundedTotalIncome = round(NSDecimalNumber(decimal: totalIncome).doubleValue * 100) / 100.0
    let roundedTotalExpense = round(NSDecimalNumber(decimal: totalExpense).doubleValue * 100) / 100.0

    self.balance.value = BalanceModel(titleBalance: titleBalance, titleIncome: titleIncome,
                                      titleExpense: titleExpense, totalBalance: roundedTotalBalance,
                                      totalIncome: roundedTotalIncome, totalExpense: roundedTotalExpense,
                                      currency: currency.title)
  }
}
