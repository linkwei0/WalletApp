//
//  OperationEditInteractor.swift
//  WalletApp
//
//  Created by Артём Бацанов on 31.10.2023.
//

import Foundation

protocol OperationEditInteractorProtocol {
  func editOperation(for wallet: WalletModel, operation: OperationModel, completion: @escaping (Result<Void, Error>) -> Void)
}

class OperationEditInteractor: OperationEditInteractorProtocol {
  private let operationUseCase: OperationUseCaseProtocol
  
  init(useCaseProvider: UseCaseProviderProtocol) {
    operationUseCase = useCaseProvider.operationUseCase()
  }
  
  func editOperation(for wallet: WalletModel, operation: OperationModel, completion: @escaping (Result<Void, Error>) -> Void) {
    operationUseCase.editOperation(for: wallet, operation: operation, completion: completion)
  }
}
