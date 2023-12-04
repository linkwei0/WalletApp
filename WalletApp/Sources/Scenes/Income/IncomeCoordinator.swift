//
//  IncomeCoordinator.swift
//  WalletApp
//

import UIKit

struct IncomeCoordinatorConfiguration {
  let wallet: WalletModel
}

protocol IncomeCoordinatorDelegate: AnyObject {
  func incomeCoordinatorDidUpdateWallet(_ coordinator: IncomeCoordinator)
}

final class IncomeCoordinator: ConfigurableCoordinator {
  typealias Configuration = IncomeCoordinatorConfiguration
  typealias Factory = HasIncomeFactory
  
  // MARK: - Properties
  weak var delegate: IncomeCoordinatorDelegate?
  
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
    showIncomeScreen(animated: animated)
  }
  
  private func showIncomeScreen(animated: Bool) {
    let incomeVC = factory.incomeFactory.makeModule(with: configuration.wallet)
    incomeVC.viewModel.delegate = self
    let currency = CurrencyModelView.WalletsCurrencyType(rawValue: configuration.wallet.currency.code) ?? .rub
    let walletBalance = NSDecimalNumber(decimal: configuration.wallet.balance).intValue.makeDigitSeparator()
    incomeVC.navigationItem.title = walletBalance + " " + currency.title
    incomeVC.viewModel.onDidCreateOperation = { [weak viewModel = incomeVC.viewModel] wallet in
      incomeVC.navigationItem.title = NSDecimalNumber(decimal: wallet.balance).intValue.makeDigitSeparator() + " " + currency.title
      viewModel?.calculationViewModel.updateOperations()
    }
    addPopObserver(for: incomeVC)
    navigationController.pushViewController(incomeVC, animated: animated)
  }
}

// MARK: - IncomeViewModelDelegate
extension IncomeCoordinator: IncomeViewModelDelegate {
  func incomeViewModelDidRequestToShowCategoryView(_ viewModel: IncomeViewModel, interactor: CalculationInteractorProtocol,
                                                   wallet: WalletModel, operation: OperationModel) {
    let categoryViewModel = CategoryPickerViewModel(interactor: interactor, wallet: wallet, operation: operation)
    let categoryPickerController = CategoryPickerViewController(viewModel: categoryViewModel)
    categoryPickerController.modalPresentationStyle = .overCurrentContext
    categoryViewModel.onNeedsToUpdateOperation = { [weak viewModel] wallet, _ in
      viewModel?.onDidCreateOperation?(wallet)
    }
    navigationController.present(categoryPickerController, animated: false)
  }
  
  func incomeViewModelDidRequestToBackWalletDetail(_ viewModel: IncomeViewModel) {
    delegate?.incomeCoordinatorDidUpdateWallet(self)
  }
}
