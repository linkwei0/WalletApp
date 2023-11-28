//
//  OperationRepository.swift
//  WalletApp
//

import Foundation

final class OperationRepository: OperationUseCaseProtocol {
  private let localDataSource: OperationLocalDataSourceProtocol
  
  init(localDataSource: OperationLocalDataSourceProtocol) {
    self.localDataSource = localDataSource
  }
  
  func getOperations(for walletID: Int, completion: @escaping (Result<[OperationModel], Error>) -> Void) {
    localDataSource.getOperations(for: walletID) { result in
      let operations = try? result.get()
      completion(.success(operations ?? []))
    }
  }
  
  func saveOperation(for wallet: WalletModel, operation: OperationModel, completion: @escaping (Result<Void, Error>) -> Void) {
    localDataSource.saveOperation(for: wallet, operation: operation, completion: completion)
  }
  
  func editOperation(for wallet: WalletModel, operation: OperationModel, completion: @escaping (Result<Void, Error>) -> Void) {
    localDataSource.editOperation(for: wallet, operation: operation, completion: completion)
  }
}
