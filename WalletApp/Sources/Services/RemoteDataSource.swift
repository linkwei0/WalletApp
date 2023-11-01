//
//  RemoteDataSource.swift
//  WalletApp
//

import Foundation

protocol RemoteDataSourceProtocol {
  func walletDataSource() -> WalletRemoteDataSourceProtocol
  func profileDataSource() -> ProfileRemoteDataSourceProtocol
}

final class RemoteDataSource: RemoteDataSourceProtocol {
  func walletDataSource() -> WalletRemoteDataSourceProtocol {
    let client = WalletClient()
    return WalletRemoteDataSource(client: client)
  }
  
  func profileDataSource() -> ProfileRemoteDataSourceProtocol {
    let client = ProfileClient()
    return ProfileRemoteDataSource(client: client)
  }
}
