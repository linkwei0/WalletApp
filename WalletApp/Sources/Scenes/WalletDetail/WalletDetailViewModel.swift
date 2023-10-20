//
//  WalletDetailViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 16.10.2023.
//

import Foundation

protocol WalletDetailViewModelDelegate: AnyObject {
  func walletDetailViewModelDidRequestToShowIncome(_ viewModel: WalletDetailViewModel, currentBalance: String)
  func walletDetailViewModelDidRequestToShowExpense(_ viewModel: WalletDetailViewModel, currentBalance: String)
  func walletDetailViewModelDidRequestToShowProfile(_ viewModel: WalletDetailViewModel)
}

class WalletDetailViewModel {
  // MARK: - Properties
  weak var delegate: WalletDetailViewModelDelegate?
  
  var bottomBarConfiguration: BankBottomBarConfiguration {
    return .walletDetail
  }
    
  private let wallet: WalletModel
  private let interactor: WalletDetailInteractor
  
  // MARK: - Init
  init(interactor: WalletDetailInteractor, wallet: WalletModel) {
    self.interactor = interactor
    self.wallet = wallet
  }
  
  // MARK: - Public methods
  func didSelectBottomBarItem(_ itemType: BankBottomBarItemType) {
    let balance = NSDecimalNumber(decimal: wallet.balance).stringValue
    
    switch itemType {
    case .income:
      delegate?.walletDetailViewModelDidRequestToShowIncome(self, currentBalance: balance)
    case .expense:
      delegate?.walletDetailViewModelDidRequestToShowExpense(self, currentBalance: balance)
    case .profile:
      delegate?.walletDetailViewModelDidRequestToShowProfile(self)
    }
  }
}
