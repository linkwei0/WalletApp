//
//  UseCaseProvider.swift
//  WalletApp
//
//  Created by Артём Бацанов on 07.08.2023.
//

import Foundation

class UseCaseProvider: UseCaseProviderProtocol {
  private let localDataSource: LocalDataSourceProtocol
  private let remoteDataSource: RemoteDataSourceProtocol
  
  init(localDataSource: LocalDataSourceProtocol, remoteDataSource: RemoteDataSourceProtocol) {
    self.localDataSource = localDataSource
    self.remoteDataSource = remoteDataSource
  }
  
  func walletUseCase() -> WalletUseCaseProtocol {
    let localDataSource = localDataSource.walletDataSource()
    let remoteDataSource = remoteDataSource.walletDataSource()
    return WalletRepository(localDataSource: localDataSource, remoteDataSource: remoteDataSource)
  }
  
  func operationUseCase() -> OperationUseCaseProtocol {
    let localDataSource = localDataSource.operationDataSource()
    return OperationRepository(localDataSource: localDataSource)
  }
}
