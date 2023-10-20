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
    let useCase = UseCaseProvider(localDataSource: localDataSource)
    let interactor = WalletsInteractor(useCaseProvider: useCase)
    let viewModel = WalletsViewModel(interactor: interactor)
    let walletsVC = WalletsViewController(viewModel: viewModel)
    return walletsVC
  }
}
