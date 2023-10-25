//
//  CreateWalletInteractor.swift
//  WalletApp
//

import Foundation

class CreateWalletInteractor {
  private let walletUseCase: WalletUseCaseProtocol
  
  init(useCaseProvider: UseCaseProviderProtocol) {
    self.walletUseCase = useCaseProvider.walletUseCase()
  }
  
  func saveWallet(_ wallet: WalletModel, completion: @escaping (Result<Void, Error>) -> Void) {
    walletUseCase.saveWallet(wallet, completion: completion)
  }
}
