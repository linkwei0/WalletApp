//
//  WalletDetailFactory.swift
//  WalletApp
//

import Foundation

protocol WalletDetailFactoryProtocol {
  func makeModule(with wallet: WalletModel) -> WalletDetailViewController
}

struct WalletDetailFactory: WalletDetailFactoryProtocol {
  let useCaseProvider: UseCaseProviderProtocol
  
  func makeModule(with wallet: WalletModel) -> WalletDetailViewController {
    let interactor = WalletDetailInteractor(useCaseProvider: useCaseProvider)
    let viewModel = WalletDetailViewModel(interactor: interactor, wallet: wallet)
    let walletDetailVC = WalletDetailViewController(viewModel: viewModel)
    return walletDetailVC
  }
}
