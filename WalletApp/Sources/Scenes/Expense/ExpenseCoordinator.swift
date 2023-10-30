//
//  ExpenseCoordinator.swift
//  WalletApp
//

import UIKit

struct ExpenseCoordinatorConfiguration {
  let wallet: WalletModel
}

protocol ExpenseCoordinatorDelegate: AnyObject {
  func expenseCoordinatorDidUpdateWallet(_ coordinator: ExpenseCoordinator)
}

final class ExpenseCoordinator: ConfigurableCoordinator {
  typealias Configuration = ExpenseCoordinatorConfiguration
  typealias Factory = HasExpenseFactory
  
  // MARK: - Properties
  weak var delegate: ExpenseCoordinatorDelegate?
  
  var childCoordinator: [Coordinator] = []
  var onDidFinish: (() -> Void)?
  
  let navigationController: NavigationController
  let appFactory: AppFactory
  
  private let factory: Factory
  private let configuration: Configuration
  
  required init(navigationController: NavigationController, appFactory: AppFactory, configuration: Configuration) {
    self.navigationController = navigationController
    self.appFactory = appFactory
    self.factory = appFactory
    self.configuration = configuration
  }
  
  func start(_ animated: Bool) {
    showExpenseScreen(animated: animated)
  }
  
  private func showExpenseScreen(animated: Bool) {
    let expenseVC = factory.expenseFactory.makeModule(with: configuration.wallet)
    expenseVC.viewModel.delegate = self
    let currency = CurrencyModelView.WalletsCurrencyType(rawValue: self.configuration.wallet.currency.code) ?? .rub
    expenseVC.navigationItem.title = NSDecimalNumber(decimal: configuration.wallet.balance).stringValue + currency.title
    expenseVC.viewModel.onDidCreatedOperation = { [weak viewModel = expenseVC.viewModel] wallet in
      expenseVC.navigationItem.title = NSDecimalNumber(decimal: wallet.balance).stringValue + currency.title
      viewModel?.calculationViewModel.updateOperations()
    }
    addPopObserver(for: expenseVC)
    navigationController.pushViewController(expenseVC, animated: animated)
  }
}

extension ExpenseCoordinator: ExpenseViewModelDelegate {
  func expenseViewModelDidRequestToShowCategoryView(_ viewModel: ExpenseViewModel, interactor: CalculationInteractorProtocol,
                                                    wallet: WalletModel, totalValue: String, calculationType: CalculationType) {
    let categoryViewModel = CategoryPickerViewModel(interactor: interactor, wallet: wallet,
                                                    totalValue: totalValue, calculationType: calculationType)
    let categoryPickerController = CategoryPickerViewController(viewModel: categoryViewModel)
    categoryPickerController.modalPresentationStyle = .overCurrentContext
    categoryViewModel.onDidCreatedOperation = { [weak viewModel] wallet in
      viewModel?.onDidCreatedOperation?(wallet)
    }
    navigationController.present(categoryPickerController, animated: false)
  }
  
  func expenseViewModelDidRequestToBackWalletDetail(_ viewModel: ExpenseViewModel) {
    delegate?.expenseCoordinatorDidUpdateWallet(self)
  }
}
