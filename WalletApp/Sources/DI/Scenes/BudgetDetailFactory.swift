//
//  BudgetDetailFactory.swift
//  WalletApp
//
//  Created by Артём Бацанов on 23.11.2023.
//

import Foundation

protocol BudgetDetailFactoryProtocol {
  func makeModule(budget: BudgetModel, currencyCode: String) -> BudgetDetailViewController
}

struct BudgetDetailFactory: BudgetDetailFactoryProtocol {
  func makeModule(budget: BudgetModel, currencyCode: String) -> BudgetDetailViewController {
    let viewModel = BudgetDetailViewModel(budget: budget, currencyCode: currencyCode)
    let viewController = BudgetDetailViewController(viewModel: viewModel)
    return viewController
  }
}
