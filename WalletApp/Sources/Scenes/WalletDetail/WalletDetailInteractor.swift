//
//  WalletDetailInteractor.swift
//  WalletApp
//

import Foundation

protocol WalletDetailInteractorProtocol {
  func getOperations(for wallet: WalletModel, completion: @escaping (Result<[OperationModel], Error>) -> Void)
}

class WalletDetailInteractor: WalletDetailInteractorProtocol {
  private let operationsUseCase: OperationUseCaseProtocol
  
  init(useCaseProvider: UseCaseProviderProtocol) {
    self.operationsUseCase = useCaseProvider.operationUseCase()
  }
  
  func getOperations(for wallet: WalletModel, completion: @escaping (Result<[OperationModel], Error>) -> Void) {
    operationsUseCase.getOperations(for: wallet, completion: completion)
  }
}
