//
//  ProfileFactory.swift
//  WalletApp
//
//  Created by Артём Бацанов on 01.11.2023.
//

import Foundation

protocol ProfileFactoryProtocol {
  func makeModule() -> ProfileViewController
}

struct ProfileFactory: ProfileFactoryProtocol {
  let useCaseProvider: UseCaseProviderProtocol

  func makeModule() -> ProfileViewController {
    let interactor = ProfileInteractor(useCaseProvider: useCaseProvider)
    let viewModel = ProfileViewModel(interactor: interactor)
    let viewController = ProfileViewController(viewModel: viewModel)
    return viewController
  }
}
