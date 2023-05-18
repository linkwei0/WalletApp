//
//  CoreDataService+CurrentBank.swift
//  WalletApp
//
//  Created by Артём Бацанов on 14.05.2023.
//

import Foundation
import CoreData

extension CoreDataManager: CurrentBankProtocol {
  func fetchCurrentBank() -> WalletEntity? {
    if let currentBank = fetchObject(entity: WalletEntity.self, context: viewContext) {
      return currentBank
    }
    return nil
  }
}
