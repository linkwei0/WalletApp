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
    _ = wallet.makePersistent(context: coreDataStack.writeContext)
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
