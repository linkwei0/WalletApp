//
//  OperationEditFactory.swift
//  WalletApp
//
//  Created by Артём Бацанов on 01.11.2023.
//

import Foundation

protocol OperationEditFactoryProtocol {
  func makeModule(wallet: WalletModel, operation: OperationModel) -> OperationEditViewController
}

struct OperationEditFactory: OperationEditFactoryProtocol {
  func makeModule(wallet: WalletModel, operation: OperationModel) -> OperationEditViewController {
    let remoteDataSource = RemoteDataSource()
    let localDataSource = LocalDataSource(coreDataStack: CoreDataStack())
    let useCaseProvider = UseCaseProvider(localDataSource: localDataSource, remoteDataSource: remoteDataSource)
    let interactor = OperationEditInteractor(useCaseProvider: useCaseProvider)
    let viewModel = OperationEditViewModel(interactor: interactor, wallet: wallet, operation: operation)
    let viewController = OperationEditViewController(viewModel: viewModel)
    return viewController
  }
}
