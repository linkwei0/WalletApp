//
//  CreateBudgetInteractor.swift
//  WalletApp
//
//  Created by Артём Бацанов on 21.11.2023.
//

import Foundation

protocol CreateBudgetInteractorProtocol {
  func saveBudget(for walletID: Int, budget: BudgetModel, completion: @escaping (Result<Void, Error>) -> Void)
}

class CreateBudgetInteractor: CreateBudgetInteractorProtocol {
  private let budgetUseCase: BudgetUseCaseProtocol
  
  init(useCaseProvider: UseCaseProviderProtocol) {
    self.budgetUseCase = useCaseProvider.budgetUseCase()
  }
  
  func saveBudget(for walletID: Int, budget: BudgetModel, completion: @escaping (Result<Void, Error>) -> Void) {
    budgetUseCase.saveBudget(for: walletID, budget: budget, completion: completion)
  }
}
