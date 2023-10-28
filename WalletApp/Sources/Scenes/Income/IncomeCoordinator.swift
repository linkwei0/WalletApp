//
//  IncomeCoordinator.swift
//  WalletApp
//

import UIKit

struct IncomeCoordinatorConfiguration {
  let wallet: WalletModel
}

final class IncomeCoordinator: ConfigurableCoordinator {
  typealias Configuration = IncomeCoordinatorConfiguration
  typealias Factory = HasIncomeFactory
  
  // MARK: - Properties
  
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
    incomeVC.viewModel.onDidCreatedOperation = { [weak viewModel = incomeVC.viewModel] in
      viewModel?.calculationViewModel.updateOperations()
    }
    incomeVC.navigationItem.title = NSDecimalNumber(decimal: configuration.wallet.balance).stringValue
    addPopObserver(for: incomeVC)
    navigationController.pushViewController(incomeVC, animated: animated)
  }
}

// MARK: - IncomeViewModelDelegate
extension IncomeCoordinator: IncomeViewModelDelegate {
  func incomeViewModelDidRequestToShowCategoryView(_ viewModel: IncomeViewModel, interactor: CalculationInteractorProtocol,
                                                   wallet: WalletModel, totalValue: String) {
    let categoryViewModel = CategoryPickerViewModel(interactor: interactor, wallet: wallet, totalValue: totalValue)
    let categoryPickerController = CategoryPickerViewController(viewModel: categoryViewModel)
    categoryPickerController.modalPresentationStyle = .overCurrentContext
    categoryViewModel.onDidCreatedOperation = { [weak viewModel] in
      viewModel?.onDidCreatedOperation?()
    }
    navigationController.present(categoryPickerController, animated: false)
  }
}
