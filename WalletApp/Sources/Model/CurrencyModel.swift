//
//  CurrencyModel.swift
//  WalletApp
//

import Foundation
import CoreData

struct CurrencyModel: Domain {
  var value: Decimal
  var isIncrease: Bool
  
  let code: String
  let description: String
  
  func makePersistent(context: NSManagedObjectContext) -> CDCurrency? {
    let currency = CDCurrency(context: context)
    currency.code = code
    currency.value = NSDecimalNumber(decimal: value)
    currency.definition = description
    currency.isIncrease = isIncrease
    return currency
  }
}

extension CurrencyModel {
  static var RUB: CurrencyModel {
    return CurrencyModel(value: 1, isIncrease: false, code: "RUB", description: "Российский рубль")
  }
}
