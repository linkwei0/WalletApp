//
//  ProfileFactory.swift
//  WalletApp
//
//  Created by Артём Бацанов on 01.11.2023.
//

import Foundation

protocol ProfileFactoryProtocol {
  func makeModule() -> ProfileViewController
}

struct ProfileFactory: ProfileFactoryProtocol {
  func makeModule() -> ProfileViewController {
    let remoteDataSource = RemoteDataSource()
    let localDataSource = LocalDataSource(coreDataStack: CoreDataStack())
    let useCaseProvider = UseCaseProvider(localDataSource: localDataSource, remoteDataSource: remoteDataSource)
    let interactor = ProfileInteractor(useCaseProvider: useCaseProvider)
    let viewModel = ProfileViewModel(interactor: interactor)
    let viewController = ProfileViewController(viewModel: viewModel)
    return viewController
  }
}
