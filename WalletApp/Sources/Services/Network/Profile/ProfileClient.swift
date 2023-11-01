//
//  ProfileClient.swift
//  WalletApp
//
//  Created by Артём Бацанов on 01.11.2023.
//

import Foundation

final class ProfileClient: APIClient, ProfileClientProtocol {
  let session: URLSession
  
  init(configuration: URLSessionConfiguration) {
    self.session = URLSession(configuration: configuration)
  }
  
  convenience init() {
    let configuration = URLSessionConfiguration.default
    configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
    self.init(configuration: configuration)
  }
  
  func getPerson(completion: @escaping (Result<Void, Error>) -> Void) {
    completion(.success(Void()))
  }
}
