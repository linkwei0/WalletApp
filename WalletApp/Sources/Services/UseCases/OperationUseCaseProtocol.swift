//
//  OperationUseCaseProtocol.swift
//  WalletApp
//

import Foundation

protocol OperationUseCaseProtocol {
  func getOperations(for walletID: Int, completion: @escaping (Result<[OperationModel], Error>) -> Void)
  func saveOperation(for wallet: WalletModel, operation: OperationModel, completion: @escaping (Result<Void, Error>) -> Void)
  func editOperation(for wallet: WalletModel, operation: OperationModel, completion: @escaping (Result<Void, Error>) -> Void)
}
