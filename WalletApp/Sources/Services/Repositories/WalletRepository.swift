//
//  WalletRepository.swift
//  WalletApp
//
//  Created by Артём Бацанов on 15.10.2023.
//

import Foundation

final class WalletRepository: WalletUseCaseProtocol {
  private let localDataSource: WalletLocalDataSourceProtocol
  
  init(localDataSource: WalletLocalDataSourceProtocol) {
    self.localDataSource = localDataSource
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
}
