//
//  CreateWalletInteractor.swift
//  WalletApp
//
//  Created by Артём Бацанов on 15.10.2023.
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
