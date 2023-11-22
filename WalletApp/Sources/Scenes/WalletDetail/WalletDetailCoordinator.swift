//
//  WalletDetailCoordinator.swift
//  WalletApp
//

import UIKit

protocol WalletDetaiCoordinatorDelegate: AnyObject {
  func walletDetailCoordinatorSuccessfullyUpdatedOperation(_ coordinator: WalletDetailCoordinator)
}

struct WalletDetailCoordinatorConfiguration {
  let wallet: WalletModel
}

class WalletDetailCoordinator: ConfigurableCoordinator {
  typealias Factory = HasWalletDetailFactory
  typealias Configuration = WalletDetailCoordinatorConfiguration
  
  // MARK: - Properties
  weak var delegate: WalletDetaiCoordinatorDelegate?
  
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
    onNeedsToUpdateWallet = { [weak self, weak viewModel = walletDetailVC.viewModel] in
      guard let strongSelf = self else { return }
      viewModel?.updateWallet()
      strongSelf.delegate?.walletDetailCoordinatorSuccessfullyUpdatedOperation(strongSelf)
    }
    walletDetailVC.title = configuration.wallet.name
    walletDetailVC.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "target"),
                                                                       style: .done, target: self,
                                                                       action: #selector(showBudgetPlanning))
    navigationController.addPopObserver(for: walletDetailVC, coordinator: self)
    navigationController.pushViewController(walletDetailVC, animated: animated)
  }
  
  // MARK: - Private methods
  @objc private func showBudgetPlanning() {
    let configuration = BudgetPlanningCoordinatorConfiguration(walletID: configuration.wallet.id)
    show(BudgetPlanningListCoordinator.self, configuration: configuration, animated: true)
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
    let coordinator = show(ExpenseCoordinator.self, configuration: configuration, animated: true)
    coordinator.delegate = self
  }
  
  func walletDetailViewModelDidRequestToShowProfile(_ viewModel: WalletDetailViewModel) {
    show(ProfileCoordinator.self, animated: true)
  }
  
  func walletDetailViewModelDidRequestToShowOperationEdit(_ viewModel: WalletDetailViewModel,
                                                          wallet: WalletModel, operation: OperationModel) {
    let configuration = OperationEditCoordinatorConfiguration(wallet: wallet, operation: operation)
    let coordinator = show(OperationEditCoordinator.self, configuration: configuration, animated: true)
    coordinator.delegate = self
  }
  
  func walletDetailViewModelDidRequestToShowOperationsScreen(_ viewModel: WalletDetailViewModel, operations: [OperationModel]) {
    let configuration = OperationListCoordinatorConfiguration(operations: operations)
    show(OperationListCoordinator.self, configuration: configuration, animated: true)
  }
}

// MARK: - IncomeCoordinatorDelegate
extension WalletDetailCoordinator: IncomeCoordinatorDelegate {
  func incomeCoordinatorDidUpdateWallet(_ coordinator: IncomeCoordinator) {
    onNeedsToUpdateWallet?()
  }
}

// MARK: - ExpenseCoordinatorDelegate
extension WalletDetailCoordinator: ExpenseCoordinatorDelegate {
  func expenseCoordinatorDidUpdateWallet(_ coordinator: ExpenseCoordinator) {
    onNeedsToUpdateWallet?()
  }
}

// MARK: - OperationEditCoordinatorDelegate
extension WalletDetailCoordinator: OperationEditCoordinatorDelegate {
  func operationEditCoordinatorSuccessfullyEdited(_ coordinator: OperationEditCoordinator) {
    onNeedsToUpdateWallet?()
  }
}
