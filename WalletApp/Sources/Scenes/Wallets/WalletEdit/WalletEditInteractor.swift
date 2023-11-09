//
//  WalletEditInteractor.swift
//  WalletApp
//
//  Created by Артём Бацанов on 08.11.2023.
//

import Foundation

class WalletEditInteractor {
  private let walletUseCase: WalletUseCaseProtocol
  
  init(useCaseProvider: UseCaseProviderProtocol) {
    walletUseCase = useCaseProvider.walletUseCase()
  }
  
  func updateWallet(wallet: WalletModel, completion: @escaping (Result<Void, Error>) -> Void) {
    walletUseCase.saveWallet(wallet, completion: completion)
  }
}
