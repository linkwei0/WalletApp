//
//  WalletLocalDataSource.swift
//  WalletApp
//
//  Created by Артём Бацанов on 15.10.2023.
//

import CoreData

protocol WalletLocalDataSourceProtocol {
  func getWallets(completion: @escaping (Result<[WalletModel], Error>) -> Void)
  func saveWallet(_ wallet: WalletModel, completion: @escaping (Result<Void, Error>) -> Void)
  func deleteWallet(with id: Int, completion: @escaping (Result<Void, Error>) -> Void)
}

class WalletLocalDataSource: WalletLocalDataSourceProtocol {
  private let coreDataStack: CoreDataStack
  
  init(coreDataStack: CoreDataStack) {
    self.coreDataStack = coreDataStack
  }
  
  func getWallets(completion: @escaping (Result<[WalletModel], Error>) -> Void) {
    let wallets = coreDataStack.getAllObjectsOfType(WalletModel.PersistentModel.self)
    completion(.success(wallets.compactMap { $0.makeDomain() }))
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
