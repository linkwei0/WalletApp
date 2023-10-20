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
  
  func getOperations(completion: @escaping (Result<[OperationModel], Error>) -> Void) {
    localDataSource.getOperations { result in
      let operations = try? result.get()
      completion(.success(operations ?? []))
    }
  }
}
