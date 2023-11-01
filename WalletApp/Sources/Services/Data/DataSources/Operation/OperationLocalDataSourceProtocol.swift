//
//  OperationLocalDataSourceProtocol.swift
//  WalletApp
//
//  Created by Артём Бацанов on 01.11.2023.
//

import Foundation

protocol OperationLocalDataSourceProtocol {
  func getOperations(for wallet: WalletModel, completion: @escaping (Result<[OperationModel], Error>) -> Void)
  func saveOperation(for wallet: WalletModel, operation: OperationModel, completion: @escaping (Result<Void, Error>) -> Void)
  func deleteOperation(with id: Int, completion: @escaping (Result<Void, Error>) -> Void)
  func editOperation(for wallet: WalletModel, operation: OperationModel, completion: @escaping (Result<Void, Error>) -> Void)
}
