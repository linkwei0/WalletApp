//
//  CDCurrency.swift
//  WalletApp
//
//  Created by Артём Бацанов on 11.10.2023.
//

import Foundation

extension CDCurrency: Persistent {
  func makeDomain() -> CurrencyModel? {
    guard let code = code, let definition = definition, let value = value?.decimalValue else { return nil }
    return CurrencyModel(code: code, value: value, description: definition, isIncrease: isIncrease)
  }
}
