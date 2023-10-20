//
//  UseCaseProvider.swift
//  WalletApp
//
//  Created by Артём Бацанов on 07.08.2023.
//

import Foundation

class UseCaseProvider: UseCaseProviderProtocol {
  private let localDataSource: LocalDataSourceProtocol
  
  init(localDataSource: LocalDataSourceProtocol) {
    self.localDataSource = localDataSource
  }
  
  func walletUseCase() -> WalletUseCaseProtocol {
    let localDataSource = localDataSource.walletDataSource()
    return WalletRepository(localDataSource: localDataSource)
  }
  
  func operationUseCase() -> OperationUseCaseProtocol {
    let localDataSource = localDataSource.operationDataSource()
    return OperationRepository(localDataSource: localDataSource)
  }
}
