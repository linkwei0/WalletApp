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
  private(set) var calculationViewModel: CalculationViewModel

  private let interactor: CalculationInteractorProtocol
  
  // MARK: - Init
  
  init(interactor: CalculationInteractorProtocol, currentBank: String) {
    self.interactor = interactor
    self.currentBank = currentBank
    self.calculationViewModel = CalculationViewModel(interactor: interactor, collectionType: .expense)
  }
}
