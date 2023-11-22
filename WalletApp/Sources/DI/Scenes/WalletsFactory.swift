//
//  WalletsFactory.swift
//  WalletApp
//

import Foundation

protocol WalletsFactoryProtocol {
  func makeModule() -> WalletsViewController
}

struct WalletsFactory: WalletsFactoryProtocol {
  let useCaseProvider: UseCaseProviderProtocol
  
  func makeModule() -> WalletsViewController {
    let interactor = WalletsInteractor(useCaseProvider: useCaseProvider)
    let viewModel = WalletsViewModel(interactor: interactor)
    let walletsVC = WalletsViewController(viewModel: viewModel)
    return walletsVC
  }
}
