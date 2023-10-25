//
//  OperationUseCaseProtocol.swift
//  WalletApp
//

import Foundation

protocol OperationUseCaseProtocol {
  func getOperations(for wallet: WalletModel, completion: @escaping (Result<[OperationModel], Error>) -> Void)
  func saveOperation(operation: OperationModel, completion: @escaping (Result<Void, Error>) -> Void)
}
