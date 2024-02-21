//
//  WalletEditCoordinator.swift
//  WalletApp
//
//  Created by Артём Бацанов on 08.11.2023.
//

import Foundation

protocol WalletEditCoordinatorDelegate: AnyObject {
  func walletEditcoordinatorSuccessfullyUpdatedWallet(_ coordinator: WalletEditCoordinator)
}

struct WalletEditCoordinatorConfiguration {
  let wallet: WalletModel
  let currencyRates: CurrencyRates
}

class WalletEditCoordinator: ConfigurableCoordinator {
  typealias Configuration = WalletEditCoordinatorConfiguration
  
  weak var delegate: WalletEditCoordinatorDelegate?
  
  var childCoordinator: [Coordinator] = []
  var onDidFinish: (() -> Void)?
  
  let navigationController: NavigationController
  let appFactory: AppFactory
  
  private let configuration: Configuration

  required init(navigationController: NavigationController, appFactory: AppFactory,
                configuration: WalletEditCoordinatorConfiguration) {
    self.navigationController = navigationController
    self.appFactory = appFactory
    self.configuration = configuration
  }
  
  func start(_ animated: Bool) {
    showWalletEditScreen(animated: animated)
  }
  
  private func showWalletEditScreen(animated: Bool) {
    let useCaseProviderFactory = appFactory.useCaseProviderFactory
    let interactor = WalletEditInteractor(useCaseProvider: useCaseProviderFactory.makeUseCaseProvider())
    let viewModel = WalletEditViewModel(interactor: interactor, wallet: configuration.wallet,
                                        currencyRates: configuration.currencyRates)
    viewModel.delegate = self
    let viewController = WalletEditViewController(viewModel: viewModel)
    viewController.navigationItem.title = R.string.wallets.walletEditTitle()
    addPopObserver(for: viewController)
    navigationController.pushViewController(viewController, animated: animated)
  }
}

// MARK: - WalletEditViewModelDelegate
extension WalletEditCoordinator: WalletEditViewModelDelegate {
  func walletEditViewModelSuccessfullyUpdated(_ viewModel: WalletEditViewModel) {
    delegate?.walletEditcoordinatorSuccessfullyUpdatedWallet(self)
    navigationController.popToRootViewController(animated: true)
  }
}
