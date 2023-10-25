//
//  WalletsFactory.swift
//  WalletApp
//

import Foundation

protocol WalletsFactoryProtocol {
  func makeModule() -> WalletsViewController
}

struct WalletsFactory: WalletsFactoryProtocol {
  func makeModule() -> WalletsViewController {
    let coreDataStack = CoreDataStack()
    let localDataSource = LocalDataSource(coreDataStack: coreDataStack)
    let remoteDataSource = RemoteDataSource()
    let useCase = UseCaseProvider(localDataSource: localDataSource, remoteDataSource: remoteDataSource)
    let interactor = WalletsInteractor(useCaseProvider: useCase)
    let viewModel = WalletsViewModel(interactor: interactor)
    let walletsVC = WalletsViewController(viewModel: viewModel)
    return walletsVC
  }
}
