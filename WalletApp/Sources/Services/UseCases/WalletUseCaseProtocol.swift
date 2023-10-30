//
//  WalletUseCaseProtocol.swift
//  WalletApp
//
//  Created by Артём Бацанов on 15.10.2023.
//

import Foundation

protocol WalletUseCaseProtocol {
  func getWallets(completion: @escaping (Result<[WalletModel], Error>) -> Void)
  func getWallet(by walletID: Int, completion: @escaping (Result<WalletModel, Error>) -> Void)
  func saveWallet(_ wallet: WalletModel, completion: @escaping (Result<Void, Error>) -> Void)
  func deleteWallet(with id: Int, completion: @escaping (Result<Void, Error>) -> Void)
  func getCurrencies(completion: @escaping (Result<[CurrencyModel], Error>) -> Void)
}
