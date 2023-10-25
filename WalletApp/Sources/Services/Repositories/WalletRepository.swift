//
//  WalletRepository.swift
//  WalletApp
//

import Foundation

final class WalletRepository: WalletUseCaseProtocol {
  private let localDataSource: WalletLocalDataSourceProtocol
  private let remoteDataSource: WalletRemoteDataSourceProtocol
  
  init(localDataSource: WalletLocalDataSourceProtocol, remoteDataSource: WalletRemoteDataSourceProtocol) {
    self.localDataSource = localDataSource
    self.remoteDataSource = remoteDataSource
  }
  
  func getWallets(completion: @escaping (Result<[WalletModel], Error>) -> Void) {
    localDataSource.getWallets(completion: completion)
  }
  
  func saveWallet(_ wallet: WalletModel, completion: @escaping (Result<Void, Error>) -> Void) {
    localDataSource.saveWallet(wallet, completion: completion)
  }
  
  func deleteWallet(with id: Int, completion: @escaping (Result<Void, Error>) -> Void) {
    localDataSource.deleteWallet(with: id, completion: completion)
  }
  
  func getCurrencies(completion: @escaping (Result<[CurrencyModel], Error>) -> Void) {
    remoteDataSource.getCurrencies(completion: completion)
  }
}
