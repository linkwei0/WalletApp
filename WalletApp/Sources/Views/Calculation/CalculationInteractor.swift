//
//  CalculationInteractor.swift
//  WalletApp
//

import Foundation

class CalculationInteractor: CalculationInteractorProtocol {
  private let operationsUseCase: OperationUseCaseProtocol
  private let budgetUseCase: BudgetUseCaseProtocol
  
  init(useCaseProvider: UseCaseProviderProtocol) {
    self.operationsUseCase = useCaseProvider.operationUseCase()
    self.budgetUseCase = useCaseProvider.budgetUseCase()
  }
  
  func getOperations(for wallet: WalletModel, completion: @escaping (Result<[OperationModel], Error>) -> Void) {
    operationsUseCase.getOperations(for: wallet, completion: completion)
  }
  
  func saveOperation(for wallet: WalletModel, operation: OperationModel, completion: @escaping (Result<Void, Error>) -> Void) {
    operationsUseCase.saveOperation(for: wallet, operation: operation, completion: completion)
    budgetUseCase.updateBudget(for: wallet.id, with: operation)
  }
}
