//
//  IncomeViewModel.swift
//  WalletApp
//

import Foundation

final class IncomeViewModel {
  private var currentBank: String
  
  private(set) var calculationViewModel: CalculationViewModel
  
  private let interactor: CalculationInteractorProtocol

  init(interactor: CalculationInteractorProtocol, currentBank: String) {
    self.interactor = interactor
    self.currentBank = currentBank
    self.calculationViewModel = CalculationViewModel(interactor: interactor, collectionType: .income)
  }
}
