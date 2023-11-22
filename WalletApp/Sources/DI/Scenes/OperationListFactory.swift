//
//  OperationListFactoryProtocol.swift
//  WalletApp
//
//  Created by Артём Бацанов on 22.11.2023.
//

import Foundation

protocol OperationListFactoryProtocol {
  func makeModule(with operations: [OperationModel]) -> OperationListViewController
}

struct OperationListFactory: OperationListFactoryProtocol {
  func makeModule(with operations: [OperationModel]) -> OperationListViewController {
    let viewModel = OperationListViewModel(operations: operations)
    let viewController = OperationListViewController(viewModel: viewModel)
    return viewController
  }
}
