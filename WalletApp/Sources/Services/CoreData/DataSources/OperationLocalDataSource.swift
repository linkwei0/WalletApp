//
//  OperationLocalDataSource.swift
//  WalletApp
//

import CoreData

protocol OperationLocalDataSourceProtocol {
  func getOperations(for wallet: WalletModel, completion: @escaping (Result<[OperationModel], Error>) -> Void)
  func saveOperation(operation: OperationModel, completion: @escaping (Result<Void, Error>) -> Void)
  func deleteOperation(with id: Int, completion: @escaping (Result<Void, Error>) -> Void)
}

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
  
  func saveOperation(operation: OperationModel, completion: @escaping (Result<Void, Error>) -> Void) {
    _ = operation.makePersistent(context: coreDataStack.writeContext)
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
}
