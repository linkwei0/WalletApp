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

// MARK: - ExpenseViewModelDelegate
extension ExpenseCoordinator: ExpenseViewModelDelegate {
  func expenseViewModelDidRequestToShowCategoryView(_ viewModel: ExpenseViewModel, interactor: CalculationInteractorProtocol,
                                                    wallet: WalletModel, operation: OperationModel) {
    let categoryViewModel = CategoryPickerViewModel(interactor: interactor, wallet: wallet, operation: operation)
    categoryViewModel.delegate = self
    let categoryPickerController = CategoryPickerViewController(viewModel: categoryViewModel)
    categoryPickerController.modalPresentationStyle = .overCurrentContext
    categoryViewModel.onNeedsToUpdateOperation = { [weak viewModel] wallet, _ in
      viewModel?.onDidCreatedOperation?(wallet)
    }
    navigationController.present(categoryPickerController, animated: false)
  }
  
  func expenseViewModelDidRequestToBackWalletDetail(_ viewModel: ExpenseViewModel) {
    delegate?.expenseCoordinatorDidUpdateWallet(self)
  }
}

// MARK: - CategoryPickerViewModelDelegate
extension ExpenseCoordinator: CategoryPickerViewModelDelegate, BannerShowing {
  func viewModelDidRequestToNotificationUser(_ viewModel: CategoryPickerViewModel, title: String, subtitle: String) {
    showBanner(title: title, subTitle: subtitle, style: .warning)
  }
}
