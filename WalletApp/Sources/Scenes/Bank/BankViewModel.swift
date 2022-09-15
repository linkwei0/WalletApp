//
//  BankViewModel.swift
//  WalletApp
//

import Foundation

protocol BankViewModelDelegate: AnyObject {
  func bankViewModelDidRequestToShowIncome(_ viewModel: BankViewModel)
  func bankViewModelDidRequestToShowExpense(_ viewModel: BankViewModel)
  func bankViewModelDidRequestToShowProfile(_ viewModel: BankViewModel)
}

class BankViewModel {
  // MARK: - Properties
  
  weak var delegate: BankViewModelDelegate?
  
  var bottomBarConfiguration: BankBottomBarConfiguration {
    return .main
  }
  
  var currentBank: String {
    return "132004 руб"
  }
  
  func didSelectBottomBarItem(_ itemType: BankBottomBarItemType) {
    switch itemType {
    case .income:
      delegate?.bankViewModelDidRequestToShowIncome(self)
    case .expense:
      delegate?.bankViewModelDidRequestToShowExpense(self)
    case .profile:
      delegate?.bankViewModelDidRequestToShowProfile(self)
    }
  }
}
