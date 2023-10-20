//
//  WalletsInteractor.swift
//  WalletApp
//
//  Created by Артём Бацанов on 16.10.2023.
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
}
