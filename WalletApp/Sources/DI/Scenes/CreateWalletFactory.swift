//
//  CreateWalletFactory.swift
//  WalletApp
//

import UIKit

protocol CreateWalletFactoryProtocol {
  func makeModule(with rates: CurrencyRates) -> CreateWalletViewController
}

struct CreateWalletFactory: CreateWalletFactoryProtocol {
  func makeModule(with rates: CurrencyRates) -> CreateWalletViewController {
    let coreDataStack = CoreDataStack()
    let localDataSource = LocalDataSource(coreDataStack: coreDataStack)
    let remoteDataSource = RemoteDataSource()
    let useCase = UseCaseProvider(localDataSource: localDataSource, remoteDataSource: remoteDataSource)
    let interactor = CreateWalletInteractor(useCaseProvider: useCase)
    let viewModel = CreateWalletViewModel(interactor: interactor, currencyRates: rates)
    let createWalletVC = CreateWalletViewController(viewModel: viewModel)
    return createWalletVC
  }
}
