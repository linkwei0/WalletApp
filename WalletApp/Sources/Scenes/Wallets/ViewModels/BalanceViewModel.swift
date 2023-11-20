//
//  BalanceViewViewModel.swift
//  WalletApp
//

import Foundation

class BalanceViewModel {
  private(set) var balance: Bindable<BalanceModel> = Bindable(BalanceModel.makeCleanModel())
  
  // MARK: - Public methods
  func updateBalance(titleBalance: String, titleIncome: String, titleExpense: String,
                     totalBalance: Decimal, totalIncome: Decimal, totalExpense: Decimal,
                     currencyCode: String) {
    let currency = CurrencyModelView.WalletsCurrencyType(rawValue: currencyCode) ?? .rub
    let balance = NSDecimalNumber(decimal: totalBalance).intValue.makeDigitSeparator()
    let income = NSDecimalNumber(decimal: totalIncome).intValue.makeDigitSeparator()
    let expense = NSDecimalNumber(decimal: totalExpense).intValue.makeDigitSeparator()

    self.balance.value = BalanceModel(titleBalance: titleBalance, titleIncome: titleIncome,
                                      titleExpense: titleExpense, totalBalance: balance,
                                      totalIncome: income, totalExpense: expense,
                                      currency: currency.title)
  }
}
