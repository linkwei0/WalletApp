//
//  CalculationInteractor.swift
//  WalletApp
//

import Foundation

struct CalculationInteractor: CalculationInteractorProtocol {
  private let operationsUseCase: OperationUseCaseProtocol
  
  init(useCaseProvider: UseCaseProviderProtocol) {
    self.operationsUseCase = useCaseProvider.operationUseCase()
  }
  
  func getOperations(for wallet: WalletModel, completion: @escaping (Result<[OperationModel], Error>) -> Void) {
    operationsUseCase.getOperations(for: wallet, completion: completion)
  }
  
  func saveOperation(for wallet: WalletModel, operation: OperationModel, completion: @escaping (Result<Void, Error>) -> Void) {
    operationsUseCase.saveOperation(for: wallet, operation: operation, completion: completion)
  }
}
