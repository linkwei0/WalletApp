//
//  WalletDetailFactory.swift
//  WalletApp
//

import Foundation

protocol WalletDetailFactoryProtocol {
  func makeModule(with wallet: WalletModel) -> WalletDetailViewController
}

struct WalletDetailFactory: WalletDetailFactoryProtocol {
  func makeModule(with wallet: WalletModel) -> WalletDetailViewController {
    let coreDataStack = CoreDataStack()
    let localDataSource = LocalDataSource(coreDataStack: coreDataStack)
    let remoteDataSource = RemoteDataSource()
    let useCase = UseCaseProvider(localDataSource: localDataSource, remoteDataSource: remoteDataSource)
    let interactor = WalletDetailInteractor(useCaseProvider: useCase)
    let viewModel = WalletDetailViewModel(interactor: interactor, wallet: wallet)
    let walletDetailVC = WalletDetailViewController(viewModel: viewModel)
    return walletDetailVC
  }
}
