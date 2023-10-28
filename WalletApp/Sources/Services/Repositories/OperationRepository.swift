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
  
  func getOperations(for wallet: WalletModel, completion: @escaping (Result<[OperationModel], Error>) -> Void) {
    localDataSource.getOperations(for: wallet) { result in
      let operations = try? result.get()
      completion(.success(operations ?? []))
    }
  }
  
  func saveOperation(_ walletID: Int, operation: OperationModel, completion: @escaping (Result<Void, Error>) -> Void) {
    localDataSource.saveOperation(walletID, operation: operation, completion: completion)
  }
}
