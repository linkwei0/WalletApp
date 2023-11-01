//
//  ProfileRemoteDataSource.swift
//  WalletApp
//
//  Created by Артём Бацанов on 01.11.2023.
//

import Foundation

protocol ProfileRemoteDataSourceProtocol {
  func getPerson(completion: @escaping (Result<Void, Error>) -> Void)
}

class ProfileRemoteDataSource: ProfileRemoteDataSourceProtocol {
  private let client: ProfileClientProtocol
  
  init(client: ProfileClientProtocol) {
    self.client = client
  }
  
  func getPerson(completion: @escaping (Result<Void, Error>) -> Void) {
    completion(.success(Void()))
  }
}
