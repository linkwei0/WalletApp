//
//  IncomeViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 13.05.2023.
//

import Foundation

final class IncomeViewModel {
  private(set) var calculationViewModel = CalculationViewViewModel(collectionType: .income)
  
  private var currentBank: String

  init(currentBank: String) {
    self.currentBank = currentBank
  }
}
