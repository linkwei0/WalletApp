//
//  BudgetPlanningFactory.swift
//  WalletApp
//
//  Created by Артём Бацанов on 22.11.2023.
//

import Foundation

protocol BudgetPlanningFactoryProtocol {
  func makeModule(with walletID: Int, currency: CurrencyModel) -> BudgetPlanningListViewController
}

struct BudgetPlanningFactory: BudgetPlanningFactoryProtocol {
  let useCaseProvider: UseCaseProviderProtocol
  
  func makeModule(with walletID: Int, currency: CurrencyModel) -> BudgetPlanningListViewController {
    let interactor = BudgetPlanningListInteractor(useCaseProvider: useCaseProvider)
    let viewModel = BudgetPlanningListViewModel(interactor: interactor, walletID: walletID, currency: currency)
    let viewController = BudgetPlanningListViewController(viewModel: viewModel)
    return viewController
  }
}
