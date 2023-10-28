//
//  WalletDetailCoordinator.swift
//  WalletApp
//

import UIKit

struct WalletDetailCoordinatorConfiguration {
  let wallet: WalletModel
}

class WalletDetailCoordinator: ConfigurableCoordinator {
  // MARK: - Properties
  typealias Factory = HasWalletDetailFactory
  typealias Configuration = WalletDetailCoordinatorConfiguration
  
  var childCoordinator: [Coordinator] = []
  var onDidFinish: (() -> Void)?
  
  let navigationController: NavigationController
  let appFactory: AppFactory
  
  private var onNeedsToUpdateWallet: (() -> Void)?
    
  private let factory: Factory
  private let configuration: Configuration
  
  // MARK: - Init
  required init(navigationController: NavigationController, appFactory: AppFactory, configuration: Configuration) {
    self.navigationController = navigationController
    self.appFactory = appFactory
    self.factory = appFactory
    self.configuration = configuration
  }
  
  // MARK: - Start
  func start(_ animated: Bool) {
    showWalletDetailScreen(animated: animated)
  }
  
  private func showWalletDetailScreen(animated: Bool) {
    let walletDetailVC = factory.walletDetailFactory.makeModule(with: configuration.wallet)
    walletDetailVC.viewModel.delegate = self
    onNeedsToUpdateWallet = { [weak viewModel = walletDetailVC.viewModel] in
      viewModel?.updateWallet()
    }
    walletDetailVC.title = configuration.wallet.name
    navigationController.addPopObserver(for: walletDetailVC, coordinator: self)
    navigationController.pushViewController(walletDetailVC, animated: animated)
  }
}

// MARK: - WalletDetailViewModelDelegate
extension WalletDetailCoordinator: WalletDetailViewModelDelegate {
  func walletDetailViewModelDidRequestToShowIncome(_ viewModel: WalletDetailViewModel, wallet: WalletModel) {
    let configuration = IncomeCoordinatorConfiguration(wallet: wallet)
    let coordinator = show(IncomeCoordinator.self, configuration: configuration, animated: true)
    coordinator.delegate = self
  }
  
  func walletDetailViewModelDidRequestToShowExpense(_ viewModel: WalletDetailViewModel, wallet: WalletModel) {
    let configuration = ExpenseCoordinatorConfiguration(wallet: wallet)
    show(ExpenseCoordinator.self, configuration: configuration, animated: true)
  }
  
  func walletDetailViewModelDidRequestToShowProfile(_ viewModel: WalletDetailViewModel) {
    show(ProfileCoordinator.self, animated: true)
  }
}

// MARK: - IncomeCoordinatorDelegate
extension WalletDetailCoordinator: IncomeCoordinatorDelegate {
  func incomeCoordinatorDidUpdateWallet(_ coordinator: IncomeCoordinator) {
    onNeedsToUpdateWallet?()
  }
}
