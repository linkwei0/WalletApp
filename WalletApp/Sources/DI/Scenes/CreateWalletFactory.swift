//
//  CreateWalletFactory.swift
//  WalletApp
//

import UIKit

protocol CreateWalletFactoryProtocol {
  func makeModule(with rates: CurrencyRates) -> CreateWalletViewController
}

struct CreateWalletFactory: CreateWalletFactoryProtocol {
  let useCaseProvider: UseCaseProviderProtocol
  
  func makeModule(with rates: CurrencyRates) -> CreateWalletViewController {
    let interactor = CreateWalletInteractor(useCaseProvider: useCaseProvider)
    let viewModel = CreateWalletViewModel(interactor: interactor, currencyRates: rates)
    let createWalletVC = CreateWalletViewController(viewModel: viewModel)
    return createWalletVC
  }
}
