//
//  CalculationProtocols.swift
//  WalletApp
//

import Foundation

protocol CalculationInteractorProtocol {
  func getOperations(for wallet: WalletModel, completion: @escaping (Result<[OperationModel], Error>) -> Void)
  func saveOperation(for walletID: Int, operation: OperationModel, completion: @escaping (Result<Void, Error>) -> Void)
}
