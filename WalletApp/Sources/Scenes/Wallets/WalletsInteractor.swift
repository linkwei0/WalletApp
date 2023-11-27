//
//  WalletsInteractor.swift
//  WalletApp
//

import Foundation

protocol WalletsInteractorProtocol {
  func getWallets(completion: @escaping (Result<[WalletModel], Error>) -> Void)
  func getCurrenciesRates(completion: @escaping (Result<[CurrencyModel], Error>) -> Void)
  func deleteWallet(with walletID: Int, completion: @escaping (Result<Void, Error>) -> Void)
}

class WalletsInteractor: WalletsInteractorProtocol {
  private let walletUseCase: WalletUseCaseProtocol
  
  init(useCaseProvider: UseCaseProviderProtocol) {
    self.walletUseCase = useCaseProvider.walletUseCase()
  }
  
  func getWallets(completion: @escaping (Result<[WalletModel], Error>) -> Void) {
    walletUseCase.getWallets(completion: completion)
  }
  
  func getCurrenciesRates(completion: @escaping (Result<[CurrencyModel], Error>) -> Void) {
    walletUseCase.getCurrencies(completion: completion)
  }
  
  func deleteWallet(with walletID: Int, completion: @escaping (Result<Void, Error>) -> Void) {
    walletUseCase.deleteWallet(with: walletID, completion: completion)
  }
}
