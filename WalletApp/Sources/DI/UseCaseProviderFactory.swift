//
//  UseCase.swift
//  WalletApp
//
//  Created by Артём Бацанов on 05.11.2023.
//

import Foundation

protocol UseCaseProviderFactoryProtocol {
  func makeUseCaseProvider() -> UseCaseProviderProtocol
}

struct UseCaseProviderFactory: UseCaseProviderFactoryProtocol {
  func makeUseCaseProvider() -> UseCaseProviderProtocol {
    let coreDataStack = CoreDataStack()
    let localDataSource = LocalDataSource(coreDataStack: coreDataStack)
    let remoteDataSource = RemoteDataSource()
    let useCaseProvider = UseCaseProvider(localDataSource: localDataSource, remoteDataSource: remoteDataSource)
    return useCaseProvider
  }
}
