//
//  ProfileRepository.swift
//  WalletApp
//
//  Created by Артём Бацанов on 01.11.2023.
//

import Foundation

final class ProfileRepository: ProfileUseCaseProtocol {
  private let localDataSource: ProfileLocalDataSourceProtocol
  private let remoteDataSource: ProfileRemoteDataSourceProtocol
  
  init(localDataSource: ProfileLocalDataSourceProtocol, remoteDataSource: ProfileRemoteDataSourceProtocol) {
    self.localDataSource = localDataSource
    self.remoteDataSource = remoteDataSource
  }
  
  func getPerson(completion: @escaping (Result<Void, Error>) -> Void) {
    localDataSource.getPerson(completion: completion)
  }
}
