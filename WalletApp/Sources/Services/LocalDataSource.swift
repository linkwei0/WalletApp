//
//  LocalDataSource.swift
//  WalletApp
//
//  Created by Артём Бацанов on 07.08.2023.
//

import Foundation

protocol LocalDataSourceProtocol {
  func operationDataSource() -> OperationLocalDataSourceProtocol
  func walletDataSource() -> WalletLocalDataSourceProtocol
  func profileDataSource() -> ProfileLocalDataSourceProtocol
}

class LocalDataSource: LocalDataSourceProtocol {
  private let coreDataStack: CoreDataStack
  
  init(coreDataStack: CoreDataStack) {
    self.coreDataStack = coreDataStack
  }
  
  func walletDataSource() -> WalletLocalDataSourceProtocol {
    return WalletLocalDataSource(coreDataStack: coreDataStack)
  }
  
  func operationDataSource() -> OperationLocalDataSourceProtocol {
    return OperationLocalDataSource(coreDataStack: coreDataStack)
  }
  
  func profileDataSource() -> ProfileLocalDataSourceProtocol {
    return ProfileLocalDataSource(coreDataStack: coreDataStack)
  }
}
