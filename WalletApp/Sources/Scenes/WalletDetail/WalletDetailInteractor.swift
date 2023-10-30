//
//  WalletDetailInteractor.swift
//  WalletApp
//

import Foundation

protocol WalletDetailInteractorProtocol {
  func getOperations(for wallet: WalletModel, completion: @escaping (Result<[OperationModel], Error>) -> Void)
  func getWallet(by walletID: Int, completion: @escaping (Result<WalletModel, Error>) -> Void)
}

class WalletDetailInteractor: WalletDetailInteractorProtocol {
  private let walletUseCase: WalletUseCaseProtocol
  private let operationsUseCase: OperationUseCaseProtocol
  
  init(useCaseProvider: UseCaseProviderProtocol) {
    self.walletUseCase = useCaseProvider.walletUseCase()
    self.operationsUseCase = useCaseProvider.operationUseCase()
  }
  
  func getOperations(for wallet: WalletModel, completion: @escaping (Result<[OperationModel], Error>) -> Void) {
    operationsUseCase.getOperations(for: wallet, completion: completion)
  }
  
  func getWallet(by walletID: Int, completion: @escaping (Result<WalletModel, Error>) -> Void) {
    walletUseCase.getWallet(by: walletID, completion: completion)
  }
}
