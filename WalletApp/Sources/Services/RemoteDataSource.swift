//
//  RemoteDataSource.swift
//  WalletApp
//

import Foundation

protocol RemoteDataSourceProtocol {
  func walletDataSource() -> WalletRemoteDataSourceProtocol
}

final class RemoteDataSource: RemoteDataSourceProtocol {
  func walletDataSource() -> WalletRemoteDataSourceProtocol {
    let client = WalletClient()
    return WalletRemoteDataSource(client: client)
  }
}
