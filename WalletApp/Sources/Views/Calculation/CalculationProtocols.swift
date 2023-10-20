//
//  CalculationProtocols.swift
//  WalletApp
//
//  Created by Артём Бацанов on 07.08.2023.
//

import Foundation

protocol CalculationInteractorProtocol {
  func getOperations(completion: @escaping (Result<[OperationModel], Error>) -> Void)
}
