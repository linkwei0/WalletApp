//
//  Wallet.swift
//  WalletApp
//

import Foundation
import CoreData

struct WalletModel: Domain {
  var id: Int
  var name: String
  var currency: String
  var balance: Decimal
  var totalSpent: Decimal
  var totalEarned: Decimal
    
  func makePersistent(context: NSManagedObjectContext) -> CDWallet? {
    let wallet = CDWallet(context: context)
    wallet.id = Int64(id)
    wallet.name = name
    wallet.currency = currency
    wallet.balance = NSDecimalNumber(decimal: balance)
    wallet.totalSpent = NSDecimalNumber(decimal: totalSpent)
    wallet.totalEarned = NSDecimalNumber(decimal: totalEarned)
    return wallet
  }
}

extension WalletModel {
  init() {
    self.id = UUID().hashValue
    self.name = ""
    self.currency = "RUB"
    self.balance = 0
    self.totalSpent = 0
    self.totalEarned = 0
  }
}
