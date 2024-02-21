//
//  CardDetailFactory.swift
//  WalletApp
//
//  Created by Артём Бацанов on 18.12.2023.
//

import Foundation

protocol CardDetailFactoryProtocol {
  func makeModule(categoryName: String, operations: [OperationModel]) -> CardDetailViewController
}

struct CardDetailFactory: CardDetailFactoryProtocol {
  func makeModule(categoryName: String, operations: [OperationModel]) -> CardDetailViewController {
    let viewModel = CardDetailViewModel(categoryName: categoryName, operations: operations)
    let viewController = CardDetailViewController(viewModel: viewModel)
    return viewController
  }
}
