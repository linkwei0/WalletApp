//
//  UseCaseProviderProtocol.swift
//  WalletApp
//
//  Created by Артём Бацанов on 07.08.2023.
//

import Foundation

protocol UseCaseProviderProtocol {
  func operationUseCase() -> OperationUseCaseProtocol
  func walletUseCase() -> WalletUseCaseProtocol
  func profileUseCase() -> ProfileUseCaseProtocol
  func budgetUseCase() -> BudgetUseCaseProtocol
}
