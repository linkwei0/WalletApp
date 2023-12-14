//
//  BudgetPlanningListInteractor.swift
//  WalletApp
//
//  Created by Артём Бацанов on 21.11.2023.
//

import Foundation

protocol BudgetPlanningListInteractorProtocol {
  func getBudgets(for walletID: Int, completion: @escaping (Result<[BudgetModel], Error>) -> Void)
  func deleteBudget(with budgetID: Int, completion: @escaping (Result<Void, Error>) -> Void)
}

class BudgetPlanningListInteractor: BudgetPlanningListInteractorProtocol {
  private let budgetUseCase: BudgetUseCaseProtocol
  
  init(useCaseProvider: UseCaseProviderProtocol) {
    self.budgetUseCase = useCaseProvider.budgetUseCase()
  }
  
  func getBudgets(for walletID: Int, completion: @escaping (Result<[BudgetModel], Error>) -> Void) {
    budgetUseCase.getBudgets(for: walletID, completion: completion)
  }
  
  func deleteBudget(with budgetID: Int, completion: @escaping (Result<Void, Error>) -> Void) {
    budgetUseCase.deleteBudget(with: budgetID, completion: completion)
  }
}
