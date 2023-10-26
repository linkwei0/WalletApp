//
//  CurrencyViewModel.swift
//  WalletApp
//

import Foundation

class CurrencyViewModel {
  private(set) var currencies: Bindable<[CurrencyModelView]> = Bindable([])
  
  func configureCurrencyView(with currencies: [CurrencyModel]) {
    var resultCurrencies: [CurrencyModelView] = []
    currencies.forEach { currency in
      let valueAsDouble = NSDecimalNumber(decimal: currency.value).doubleValue
      let roundedValue = round(valueAsDouble * 100) / 100.0
      let currencyModelView = CurrencyModelView(value: roundedValue,
                                                isIncrease: currency.isIncrease,
                                                code: currency.code,
                                                description: currency.description)
      resultCurrencies.append(currencyModelView)
    }
    self.currencies.value = resultCurrencies
  }
}
