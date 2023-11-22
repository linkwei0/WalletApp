//
//  OperationEditFactory.swift
//  WalletApp
//
//  Created by Артём Бацанов on 01.11.2023.
//

import Foundation

protocol OperationEditFactoryProtocol {
  func makeModule(wallet: WalletModel, operation: OperationModel) -> OperationEditViewController
  func makeCategoryPicker(_ wallet: WalletModel, with operation: OperationModel) -> CategoryPickerViewController
}

struct OperationEditFactory: OperationEditFactoryProtocol {
  let useCaseProvider: UseCaseProviderProtocol

  func makeModule(wallet: WalletModel, operation: OperationModel) -> OperationEditViewController {
    let interactor = OperationEditInteractor(useCaseProvider: useCaseProvider)
    let viewModel = OperationEditViewModel(interactor: interactor, wallet: wallet, operation: operation)
    let viewController = OperationEditViewController(viewModel: viewModel)
    return viewController
  }
  
  func makeCategoryPicker(_ wallet: WalletModel, with operation: OperationModel) -> CategoryPickerViewController {
    let interactor = CalculationInteractor(useCaseProvider: useCaseProvider)
    let categoryViewModel = CategoryPickerViewModel(interactor: interactor, wallet: wallet, operation: operation)
    let categoryPickerController = CategoryPickerViewController(viewModel: categoryViewModel)
    return categoryPickerController
  }
}
