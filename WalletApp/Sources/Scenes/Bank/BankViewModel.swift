//
//  BankViewModel.swift
//  WalletApp
//

import Foundation

protocol BankViewModelDelegate: AnyObject {
  func bankViewModelDidRequestToShowIncome(_ viewModel: BankViewModel, currentBank: String)
  func bankViewModelDidRequestToShowExpense(_ viewModel: BankViewModel, currentBank: String)
  func bankViewModelDidRequestToShowProfile(_ viewModel: BankViewModel)
}

final class BankViewModel {
  // MARK: - Properties
  
  weak var delegate: BankViewModelDelegate?
  
  var bottomBarConfiguration: BankBottomBarConfiguration {
    return .main
  }
  
  private(set) var currentBank = "142800$"
  
  func didSelectBottomBarItem(_ itemType: BankBottomBarItemType) {
    switch itemType {
    case .income:
      delegate?.bankViewModelDidRequestToShowIncome(self, currentBank: currentBank)
    case .expense:
      delegate?.bankViewModelDidRequestToShowExpense(self, currentBank: currentBank)
    case .profile:
      delegate?.bankViewModelDidRequestToShowProfile(self)
    }
  }
}
