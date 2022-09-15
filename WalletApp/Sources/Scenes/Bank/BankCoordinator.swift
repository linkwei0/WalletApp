//
//  BankCoordinator.swift
//  WalletApp
//

import UIKit

class BankCoordinator: Coordinator {
  // MARK: - Properties
  
  var childCoordinator: [Coordinator] = []
  var onDidFinish: (() -> Void)?
  
  let navigationController: UINavigationController
  let appDependency: AppDependency
  
  // MARK: - Init
  
  required init(navigationController: UINavigationController, appDependency: AppDependency) {
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
    navigationController.pushViewController(bankVC, animated: animated)
  }
}

extension BankCoordinator: BankViewModelDelegate {
  func bankViewModelDidRequestToShowIncome(_ viewModel: BankViewModel) {
    show(IncomeCoordinator.self, animated: true)
  }
  
  func bankViewModelDidRequestToShowExpense(_ viewModel: BankViewModel) {
    show(ExpenseCoordinator.self, animated: true)
  }
  
  func bankViewModelDidRequestToShowProfile(_ viewModel: BankViewModel) {
    show(ProfileCoordinator.self, animated: true)
  }
}
