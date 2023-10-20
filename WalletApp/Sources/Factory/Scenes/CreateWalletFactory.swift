//
//  CreateWalletFactory.swift
//  WalletApp
//

import UIKit

protocol CreateWalletFactoryProtocol {
  func makeModule() -> CreateWalletViewController
}

struct CreateWalletFactory: CreateWalletFactoryProtocol {
  func makeModule() -> CreateWalletViewController {
    let coreDataStack = CoreDataStack()
    let localDataSource = LocalDataSource(coreDataStack: coreDataStack)
    let useCase = UseCaseProvider(localDataSource: localDataSource)
    let interactor = CreateWalletInteractor(useCaseProvider: useCase)
    let viewModel = CreateWalletViewModel(interactor: interactor)
    let createWalletVC = CreateWalletViewController(viewModel: viewModel)
    return createWalletVC
  }
}
