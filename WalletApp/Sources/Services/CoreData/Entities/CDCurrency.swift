//
//  CDCurrency.swift
//  WalletApp
//

import Foundation

extension CDCurrency: Persistent {
  func makeDomain() -> CurrencyModel? {
    guard let code = code, let definition = definition, let value = value?.decimalValue else { return nil }
    return CurrencyModel(value: value, isIncrease: isIncrease, code: code, description: definition)
  }
}
