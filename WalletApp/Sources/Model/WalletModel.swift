//
//  Wallet.swift
//  WalletApp
//

import Foundation
import CoreData

struct WalletModel: Domain {
  var id: Int
  var name: String
  var currency: CurrencyModel
  var balance: Decimal
  var totalSpent: Decimal
  var totalEarned: Decimal
    
  func makePersistent(context: NSManagedObjectContext) -> CDWallet? {
    let wallet = CDWallet(context: context)
    wallet.id = Int64(id)
    wallet.name = name
    wallet.currency = currency.makePersistent(context: context)
    wallet.balance = NSDecimalNumber(decimal: balance)
    wallet.totalSpent = NSDecimalNumber(decimal: totalSpent)
    wallet.totalEarned = NSDecimalNumber(decimal: totalEarned)
    return wallet
  }
}

extension WalletModel {
  static func makeCleanModel() -> WalletModel {
    return WalletModel(id: UUID().hashValue, name: "", currency: CurrencyModel.RUB, balance: 0, totalSpent: 0, totalEarned: 0)
  }
}
