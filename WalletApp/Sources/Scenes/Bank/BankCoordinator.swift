//
//  BankCoordinator.swift
//  WalletApp
//

import UIKit

final class BankCoordinator: Coordinator {
  // MARK: - Properties
  
  var childCoordinator: [Coordinator] = []
  var onDidFinish: (() -> Void)?
  
  let navigationController: NavigationController
  let appDependency: AppDependency
  
  // MARK: - Init
  
  required init(navigationController: NavigationController, appDependency: AppDependency) {
    self.navigationController = navigationController
    self.appDependency = appDependency
  }
  
  // MARK: - Start
  
  func start(_ animated: Bool) {
    showBankScreen(animated: animated)
  }
  
  private func showBankScreen(animated: Bool) {
    let viewModel = BankViewModel()
    viewModel.delegate = self
    let bankVC = BankViewController(viewModel: viewModel)
    bankVC.title = R.string.bank.bankTitle()
    addPopObserver(for: bankVC)
    navigationController.pushViewController(bankVC, animated: animated)
  }
}

extension BankCoordinator: BankViewModelDelegate {
  func bankViewModelDidRequestToShowIncome(_ viewModel: BankViewModel, currentBank: String) {
    let configuration = IncomeCoordinatorConfiguration(currentBank: viewModel.currentBank)
    show(IncomeCoordinator.self, configuration: configuration, animated: true)
  }
  
  func bankViewModelDidRequestToShowExpense(_ viewModel: BankViewModel, currentBank: String) {
    let configuration = ExpenseCoordinatorConfiguration(currentBank: viewModel.currentBank)
    show(ExpenseCoordinator.self, configuration: configuration, animated: true)
  }
  
  func bankViewModelDidRequestToShowProfile(_ viewModel: BankViewModel) {
    show(ProfileCoordinator.self, animated: true)
  }
}
