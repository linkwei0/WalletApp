//
//  BalanceViewViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 16.10.2023.
//

import Foundation

class BalanceViewModel {
  private(set) var balance: Bindable<BalanceModel> = Bindable(BalanceModel())
  
  // MARK: - Public methods
  func setBalanceModel(_ balance: BalanceModel) {
    self.balance.value = balance
  }
}
