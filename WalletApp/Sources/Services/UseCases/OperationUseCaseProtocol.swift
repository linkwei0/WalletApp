//
//  OperationUseCaseProtocol.swift
//  WalletApp
//

import Foundation

protocol OperationUseCaseProtocol {
  func getOperations(completion: @escaping (Result<[OperationModel], Error>) -> Void)
}
