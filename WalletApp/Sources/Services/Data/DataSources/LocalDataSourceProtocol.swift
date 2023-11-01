//
//  LocalDataSourceProtocol.swift
//  WalletApp
//
//  Created by Артём Бацанов on 01.11.2023.
//

import Foundation

protocol LocalDataSourceProtocol {
  func operationDataSource() -> OperationLocalDataSourceProtocol
  func walletDataSource() -> WalletLocalDataSourceProtocol
  func profileDataSource() -> ProfileLocalDataSourceProtocol
}
