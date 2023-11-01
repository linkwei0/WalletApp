//
//  WalletClient.swift
//  WalletApp
//

import Foundation

final class WalletClient: APIClient, WalletClientProtocol {
  let session: URLSession
  
  init(configuration: URLSessionConfiguration) {
    self.session = URLSession(configuration: configuration)
  }
  
  convenience init() {
    let configuration = URLSessionConfiguration.default
    configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
    self.init(configuration: configuration)
  }
  
  func getCurrencies(completion: @escaping (Result<ValuteResult?, APIError>) -> Void) {
    let request = WalletProvider.getCurrencies.request
    fetch(with: request, decode: { json in
      guard let walletResult = json as? ValuteResult else { return nil }
      return walletResult
    }, completion: completion)
  }
}
