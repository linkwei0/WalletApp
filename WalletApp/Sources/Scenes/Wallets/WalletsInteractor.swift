//
//  WalletsInteractor.swift
//  WalletApp
//

import Foundation

class WalletsInteractor {
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
}
