//
//  CreateBudgetFactory.swift
//  WalletApp
//
//  Created by Артём Бацанов on 22.11.2023.
//

import Foundation

protocol CreateBudgetFactoryProtocol {
  func makeModule(with walletID: Int) -> CreateBudgetViewController
  func makePeriodModule() -> SelectPeriodViewController
  func makeCategoryModule() -> SelectCategoryViewController
}

struct CreateBudgetFactory: CreateBudgetFactoryProtocol {
  let useCaseProvider: UseCaseProviderProtocol
  
  func makeModule(with walletID: Int) -> CreateBudgetViewController {
    let intercator = CreateBudgetInteractor(useCaseProvider: useCaseProvider)
    let viewModel = CreateBudgetViewModel(interactor: intercator, walletID: walletID)
    let viewController = CreateBudgetViewController(viewModel: viewModel)
    return viewController
  }
  
  func makePeriodModule() -> SelectPeriodViewController {
    let viewModel = SelectPeriodViewModel()
    let viewController = SelectPeriodViewController(viewModel: viewModel)
    return viewController
  }
  
  func makeCategoryModule() -> SelectCategoryViewController {
    let viewModel = SelectCategoryViewModel()
    let viewController = SelectCategoryViewController(viewModel: viewModel)
    return viewController
  }
}
