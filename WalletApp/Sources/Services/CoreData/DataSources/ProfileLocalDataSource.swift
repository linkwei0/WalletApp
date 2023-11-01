//
//  ProfileLocalDataSource.swift
//  WalletApp
//
//  Created by Артём Бацанов on 01.11.2023.
//

import Foundation

protocol ProfileLocalDataSourceProtocol {
  func getPerson(completion: @escaping (Result<Void, Error>) -> Void)
}

class ProfileLocalDataSource: ProfileLocalDataSourceProtocol {
  private let coreDataStack: CoreDataStack
  
  init(coreDataStack: CoreDataStack) {
    self.coreDataStack = coreDataStack
  }
  
  func getPerson(completion: @escaping (Result<Void, Error>) -> Void) {
    completion(.success(Void()))
  }
}
