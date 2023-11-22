//
//  IncomeFactory.swift
//  WalletApp
//

import Foundation

protocol IncomeFactoryProtocol {
  func makeModule(with wallet: WalletModel) -> IncomeViewController
}

struct IncomeFactory: IncomeFactoryProtocol {
  let useCaseProvider: UseCaseProviderProtocol

  func makeModule(with wallet: WalletModel) -> IncomeViewController {
    let interactor = CalculationInteractor(useCaseProvider: useCaseProvider)
    let incomeViewModel = IncomeViewModel(interactor: interactor, wallet: wallet)
    let incomeVC = IncomeViewController(viewModel: incomeViewModel)
    return incomeVC
  }
}
