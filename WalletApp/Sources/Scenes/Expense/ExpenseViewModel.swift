//
//  ExpenseViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 14.05.2023.
//

import Foundation

final class ExpenseViewModel {
  // MARK: - Properties
  
  private var currentBank: String
  private(set) var calculationViewModel = CalculationViewViewModel(collectionType: .expense)
  
  // MARK: - Init
  
  init(currentBank: String) {
    self.currentBank = currentBank
  }
}
