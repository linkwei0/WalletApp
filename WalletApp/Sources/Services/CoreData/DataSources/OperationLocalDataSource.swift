//
//  OperationLocalDataSource.swift
//  WalletApp
//

import CoreData

final class OperationLocalDataSource: OperationLocalDataSourceProtocol {
  private let coreDataStack: CoreDataStack
  
  init(coreDataStack: CoreDataStack) {
    self.coreDataStack = coreDataStack
  }
  
  func getOperations(for wallet: WalletModel, completion: @escaping (Result<[OperationModel], Error>) -> Void) {
    let operations = coreDataStack.getObjectByValue(columnName: #keyPath(CDOperation.walletId),
                                                    value: String(wallet.id), type: CDOperation.self)
    completion(.success(operations.compactMap { $0.makeDomain() }))
  }
  
  func saveOperation(for wallet: WalletModel, operation: OperationModel, completion: @escaping (Result<Void, Error>) -> Void) {
    guard let walletCD = coreDataStack.getObjectByValue(columnName: "id", value: String(wallet.id),
                                                        type: CDWallet.self,
                                                        context: coreDataStack.writeContext).first else { return }
    guard let operationCD = operation.makePersistent(context: coreDataStack.writeContext) else { return }
    
    walletCD.addToOperations(operationCD)
    updateWalletValues(wallet, walletCD)
    
    do {
      try coreDataStack.saveWriteContext()
      completion(.success(Void()))
    } catch {
      completion(.failure(error))
    }
  }
  
  func editOperation(for wallet: WalletModel, operation: OperationModel, completion: @escaping (Result<Void, Error>) -> Void) {
    guard let operationCD = coreDataStack.getObjectByValue(columnName: "id",
                                                           value: String(operation.id),
                                                           type: CDOperation.self,
                                                           context: coreDataStack.writeContext).first,
          let walletCD = coreDataStack.getObjectByValue(columnName: "id",
                                                        value: String(wallet.id),
                                                        type: CDWallet.self,
                                                        context: coreDataStack.writeContext).first else { return }
    operationCD.name = operation.name
    operationCD.category = operation.category
    operationCD.amount = NSDecimalNumber(decimal: operation.amount)
    operationCD.definition = operation.definition
    
    updateWalletValues(wallet, walletCD)
    
    do {
      try coreDataStack.saveWriteContext()
      completion(.success(Void()))
    } catch {
      completion(.failure(error))
    }
  }
  
  func deleteOperation(with id: Int, completion: @escaping (Result<Void, Error>) -> Void) {
    do {
      try coreDataStack.deleteObjectByValue(columnName: "id", value: String(id), type: CDOperation.self)
      completion(.success(Void()))
    } catch {
      completion(.failure(error))
    }
  }
  
  private func updateWalletValues(_ wallet: WalletModel, _ walletCD: CDWallet) {
    walletCD.balance = NSDecimalNumber(decimal: wallet.balance)
    walletCD.totalEarned = NSDecimalNumber(decimal: wallet.totalEarned)
    walletCD.totalSpent = NSDecimalNumber(decimal: wallet.totalSpent)
  }
}
