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
  
  func saveOperation(operation: OperationModel, completion: @escaping (Result<Void, Error>) -> Void) {
    operationsUseCase.saveOperation(operation: operation, completion: completion)
  }
}
