//
//  BudgetRepository.swift
//  WalletApp
//
//  Created by Артём Бацанов on 21.11.2023.
//

import Foundation

final class BudgetRepository: BudgetUseCaseProtocol {
  private let localDataSource: BudgetLocalDataSourceProtocol
  
  init(localDataSource: BudgetLocalDataSourceProtocol) {
    self.localDataSource = localDataSource
  }
  
  func saveBudget(for walletID: Int, budget: BudgetModel, completion: @escaping (Result<Void, Error>) -> Void) {
    localDataSource.saveBudget(for: walletID, budget: budget, completion: completion)
  }
  
  func getBudgets(for walletID: Int, completion: @escaping (Result<[BudgetModel], Error>) -> Void) {
    localDataSource.getBudgets(for: walletID, completion: completion)
  }
  
  func updateBudget(for walletID: Int, with operation: OperationModel, completion: @escaping (Result<BudgetModel?, Error>) -> Void) {
    localDataSource.updateBudget(for: walletID, with: operation, completion: completion)
  }
}
