//
//  ExpenseViewModel.swift
//  WalletApp
//

import Foundation

final class ExpenseViewModel {
  // MARK: - Properties
  private(set) var calculationViewModel: CalculationViewModel

  private let wallet: WalletModel
  private let interactor: CalculationInteractorProtocol
  
  // MARK: - Init
  
  init(interactor: CalculationInteractorProtocol, wallet: WalletModel) {
    self.interactor = interactor
    self.wallet = wallet
    self.calculationViewModel = CalculationViewModel(interactor: interactor, wallet: wallet, collectionType: .expense)
  }
}
