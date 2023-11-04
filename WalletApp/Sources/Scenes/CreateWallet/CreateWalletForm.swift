//
//  CreateWalletForm.swift
//  WalletApp
//

import Foundation

enum CreateWalletForm: Int, CaseIterable {
  case name, currency, balance
  
  var title: String {
    switch self {
    case .name:
      return R.string.createWallet.createWalletFormTitleName()
    case .currency:
      return R.string.createWallet.createWalletFormTitleCurrency()
    case .balance:
      return R.string.createWallet.createWalletFormTitleBalance()
    }
  }
  
  var placeholder: String {
    switch self {
    case .name:
      return R.string.createWallet.createWalletFormPlaceholderName()
    case .currency:
      return R.string.createWallet.createWalletFormPlaceholderCurrency()
    case .balance:
      return R.string.createWallet.createWalletFormPlaceholderBalance()
    }
  }
  
  var tag: Int {
    switch self {
    case .name:
      return 0
    case .currency:
      return 1
    case .balance:
      return 2
    }
  }
  
  var hiddenIfNotCurrency: Bool {
    switch self {
    case .name, .balance:
      return true
    case .currency:
      return false
    }
  }
  
  var hiddenIfNotTextField: Bool {
    switch self {
    case .name, .balance:
      return false
    case .currency:
      return true
    }
  }
}
