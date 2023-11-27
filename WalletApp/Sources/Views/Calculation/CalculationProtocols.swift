//
//  CalculationProtocols.swift
//  WalletApp
//

import Foundation

protocol CalculationInteractorProtocol {
  func getOperations(for wallet: WalletModel, completion: @escaping (Result<[OperationModel], Error>) -> Void)
  func saveOperation(for wallet: WalletModel, operation: OperationModel, completion: @escaping (Result<Void, Error>) -> Void)
  func updateBudgets(for walletID: Int, with operation: OperationModel, completion: @escaping (Result<BudgetModel?, Error>) -> Void)
}
