//
//  ExpenseFactory.swift
//  WalletApp
//

import Foundation

protocol ExpenseFactoryProtocol {
  func makeModule(with wallet: WalletModel) -> ExpenseViewController
}

struct ExpenseFactory: ExpenseFactoryProtocol {
  func makeModule(with wallet: WalletModel) -> ExpenseViewController {
    let coreDataStack = CoreDataStack()
    let localDataSource: LocalDataSourceProtocol = LocalDataSource(coreDataStack: coreDataStack)
    let remoteDataSource = RemoteDataSource()
    let useCase = UseCaseProvider(localDataSource: localDataSource, remoteDataSource: remoteDataSource)
    let interactor = CalculationInteractor(useCaseProvider: useCase)
    let expenseViewModel = ExpenseViewModel(interactor: interactor, wallet: wallet)
    let expenseVC = ExpenseViewController(viewModel: expenseViewModel)
    return expenseVC
  }
}
