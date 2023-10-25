//
//  BalanceViewViewModel.swift
//  WalletApp
//

import Foundation

class BalanceViewModel {
  private(set) var balance: Bindable<BalanceModel> = Bindable(BalanceModel())
  
  // MARK: - Public methods
  func setBalanceModel(_ balance: BalanceModel) {
    self.balance.value = balance
  }
}
