//
//  WalletLocalDataSourceProtocol.swift
//  WalletApp
//
//  Created by Артём Бацанов on 01.11.2023.
//

import Foundation

protocol WalletLocalDataSourceProtocol {
  func getWallets(completion: @escaping (Result<[WalletModel], Error>) -> Void)
  func getWallet(by walletID: Int, completion: @escaping (Result<WalletModel, Error>) -> Void)
  func saveWallet(_ wallet: WalletModel, completion: @escaping (Result<Void, Error>) -> Void)
  func deleteWallet(with id: Int, completion: @escaping (Result<Void, Error>) -> Void)
}
