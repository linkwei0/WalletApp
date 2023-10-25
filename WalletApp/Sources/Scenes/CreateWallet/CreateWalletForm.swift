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
      return "Название"
    case .currency:
      return "Валюта"
    case .balance:
      return "Баланс"
    }
  }
  
  var placeholder: String {
    switch self {
    case .name:
      return "Введите название кошелька"
    case .currency:
      return "Выберите валюту"
    case .balance:
      return "Изначальный баланс"
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
