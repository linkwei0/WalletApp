//
//  WalletLocalDataSource.swift
//  WalletApp
//
//  Created by Артём Бацанов on 15.10.2023.
//

import CoreData

class WalletLocalDataSource: WalletLocalDataSourceProtocol {
  private let coreDataStack: CoreDataStack
  
  init(coreDataStack: CoreDataStack) {
    self.coreDataStack = coreDataStack
  }
  
  func getWallets(completion: @escaping (Result<[WalletModel], Error>) -> Void) {
    let wallets = coreDataStack.getAllObjectsOfType(WalletModel.PersistentModel.self)
    completion(.success(wallets.compactMap { $0.makeDomain() }))
  }
  
  func getWallet(by walletID: Int, completion: @escaping (Result<WalletModel, Error>) -> Void) {
    let wallet = coreDataStack.getObjectByValue(columnName: "id", value: String(walletID),
                                                type: WalletModel.PersistentModel.self).first
    guard let wallet = wallet?.makeDomain() else { return }
    completion(.success(wallet))
  }
  
  func saveWallet(_ wallet: WalletModel, completion: @escaping (Result<Void, Error>) -> Void) {
    if let existedWallet = coreDataStack.getObjectByValue(columnName: "id",
                                                          value: String(wallet.id),
                                                          type: CDWallet.self,
                                                          context: coreDataStack.writeContext).first {
      let existedWalletOperations = coreDataStack.getObjectByValue(columnName: #keyPath(CDOperation.walletId),
                                                      value: String(wallet.id),
                                                      type: CDOperation.self,
                                                      context: coreDataStack.writeContext)
      existedWalletOperations.forEach { operation in
        let currencyRate = wallet.currency.value
        let operationValue: Decimal = operation.amount?.decimalValue ?? 0
        let newOperationValue = currencyRate * operationValue
        operation.amount = NSDecimalNumber(decimal: newOperationValue)
        existedWallet.addToOperations(operation)
      }
      
      existedWallet.name = wallet.name
      existedWallet.currency = wallet.currency.makePersistent(context: coreDataStack.writeContext)
      existedWallet.balance = NSDecimalNumber(decimal: wallet.balance)
    } else {
      _ = wallet.makePersistent(context: coreDataStack.writeContext)
    }
    
    do {
      try coreDataStack.saveWriteContext()
      completion(.success(Void()))
    } catch {
      completion(.failure(error))
    }
  }
  
  func deleteWallet(with id: Int, completion: @escaping (Result<Void, Error>) -> Void) {
    do {
      try coreDataStack.deleteObjectByValue(columnName: "id", value: "\(id)", type: CDWallet.self)
      completion(.success(Void()))
    } catch {
      completion(.failure(error))
    }
  }
}
