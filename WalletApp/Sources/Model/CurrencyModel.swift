//
//  CurrencyModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 11.10.2023.
//

import Foundation
import CoreData

struct CurrencyModel: Domain {
  let code: String
  let value: Decimal
  let description: String
  
  var isIncrease: Bool
  
  func makePersistent(context: NSManagedObjectContext) -> CDCurrency? {
    let currency = CDCurrency(context: context)
    currency.code = code
    currency.value = NSDecimalNumber(decimal: value)
    currency.definition = description
    currency.isIncrease = isIncrease
    return currency
  }
}
