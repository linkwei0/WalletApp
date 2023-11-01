//
//  WalletClientProtocol.swift
//  WalletApp
//

import Foundation

protocol WalletClientProtocol {
  func getCurrencies(completion: @escaping (Result<ValuteResult?, APIError>) -> Void)
}
