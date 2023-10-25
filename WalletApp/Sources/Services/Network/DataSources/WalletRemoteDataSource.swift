//
//  WalletRemoteDataSource.swift
//  WalletApp
//

import UIKit

protocol WalletRemoteDataSourceProtocol {
  func getCurrencies(completion: @escaping (Result<[CurrencyModel], Error>) -> Void)
}

final class WalletRemoteDataSource: WalletRemoteDataSourceProtocol {
  private let client: WalletClientProtocol
  
  init(client: WalletClientProtocol) {
    self.client = client
  }
  
  func getCurrencies(completion: @escaping (Result<[CurrencyModel], Error>) -> Void) {
    client.getCurrencies { result in
      switch result {
      case .success(let valuteResult):
        guard let valuteResult = valuteResult else { return }
        let currencies = valuteResult.result.map { CurrencyModel(value: Decimal($0.value.value),
                                                                 isIncrease: $0.value.value > $0.value.previous,
                                                                 code: $0.value.charCode,
                                                                 description: $0.value.name) }
        completion(.success(currencies))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
