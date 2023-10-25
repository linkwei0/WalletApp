//
//  IncomeFactory.swift
//  WalletApp
//

import Foundation

protocol IncomeFactoryProtocol {
  func makeModule(with wallet: WalletModel) -> IncomeViewController
}

struct IncomeFactory: IncomeFactoryProtocol {
  func makeModule(with wallet: WalletModel) -> IncomeViewController {
    let coreDataStack = CoreDataStack()
    let localDataSource = LocalDataSource(coreDataStack: coreDataStack)
    let remoteDataSource = RemoteDataSource()
    let useCase = UseCaseProvider(localDataSource: localDataSource, remoteDataSource: remoteDataSource)
    let interactor = CalculationInteractor(useCaseProvider: useCase)
    let incomeViewModel = IncomeViewModel(interactor: interactor, wallet: wallet)
    let incomeVC = IncomeViewController(viewModel: incomeViewModel)
    return incomeVC
  }
}
