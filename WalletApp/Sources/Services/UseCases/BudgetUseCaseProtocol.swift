//
//  BudgetUseCaseProtocol.swift
//  WalletApp
//
//  Created by Артём Бацанов on 21.11.2023.
//

import Foundation

protocol BudgetUseCaseProtocol {
  func saveBudget(for walletID: Int, budget: BudgetModel, completion: @escaping (Result<Void, Error>) -> Void)
  func getBudgets(for walletID: Int, completion: @escaping (Result<[BudgetModel], Error>) -> Void)
  func updateBudget(for walletID: Int, with operation: OperationModel, 
                    completion: @escaping (Result<BudgetModel?, Error>) -> Void)
  func deleteBudget(with budgetID: Int, completion: @escaping (Result<Void, Error>) -> Void)
}
