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
  
  func getOperations(completion: @escaping(Result<[OperationModel], Error>) -> Void) {
    operationsUseCase.getOperations(completion: completion)
  }
}
