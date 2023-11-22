//
//  ExpenseFactory.swift
//  WalletApp
//

import Foundation

protocol ExpenseFactoryProtocol {
  func makeModule(with wallet: WalletModel) -> ExpenseViewController
}

struct ExpenseFactory: ExpenseFactoryProtocol {
  let useCaseProvider: UseCaseProviderProtocol

  func makeModule(with wallet: WalletModel) -> ExpenseViewController {
    let interactor = CalculationInteractor(useCaseProvider: useCaseProvider)
    let expenseViewModel = ExpenseViewModel(interactor: interactor, wallet: wallet)
    let expenseVC = ExpenseViewController(viewModel: expenseViewModel)
    return expenseVC
  }
}
