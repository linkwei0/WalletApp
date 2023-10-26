//
//  BalanceViewViewModel.swift
//  WalletApp
//

import Foundation

class BalanceViewModel {
  private(set) var balance: Bindable<BalanceModel> = Bindable(BalanceModel())
  
  // MARK: - Public methods
  func updateBalance(with balance: BalanceModel) {
    let roundedTotalBalance = round(balance.totalBalance * 100) / 100.0
    let roundedTotalIncome = round(balance.totalIncome * 100) / 100.0
    let roundedTotalExpense = round(balance.totalExpense * 100) / 100.0
    
    self.balance.value = BalanceModel(totalBalance: roundedTotalBalance,
                                      totalIncome: roundedTotalIncome,
                                      totalExpense: roundedTotalExpense)
  }
}
