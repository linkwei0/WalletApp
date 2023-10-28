//
//  OperationUseCaseProtocol.swift
//  WalletApp
//

import Foundation

protocol OperationUseCaseProtocol {
  func getOperations(for wallet: WalletModel, completion: @escaping (Result<[OperationModel], Error>) -> Void)
  func saveOperation(_ walletID: Int, operation: OperationModel, completion: @escaping (Result<Void, Error>) -> Void)
}
