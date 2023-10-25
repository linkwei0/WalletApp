//
//  AppFactory.swift
//  WalletApp
//

import Foundation

protocol HasWalletsFactory {
  var walletsFactory: WalletsFactoryProtocol { get }
}

protocol HasCreateWalletFactory {
  var createWalletFactory: CreateWalletFactoryProtocol { get }
}

protocol HasWalletDetailFactory {
  var walletDetailFactory: WalletDetailFactoryProtocol { get }
}

protocol HasIncomeFactory {
  var incomeFactory: IncomeFactoryProtocol { get }
}

protocol HasExpenseFactory {
  var expenseFactory: ExpenseFactoryProtocol { get }
}

final class AppFactory {
  private let walletsFactoryService: WalletsFactory
  private let createWalletFactoryService: CreateWalletFactory
  private let walletDetailFactoryService: WalletDetailFactory
  private let incomeFactoryService: IncomeFactory
  private let expenseFactoryService: ExpenseFactory
  
  init() {
    walletsFactoryService = WalletsFactory()
    createWalletFactoryService = CreateWalletFactory()
    walletDetailFactoryService = WalletDetailFactory()
    incomeFactoryService = IncomeFactory()
    expenseFactoryService = ExpenseFactory()
  }
}

// MARK: - HasWalletsFactory
extension AppFactory: HasWalletsFactory {
  var walletsFactory: WalletsFactoryProtocol {
    return walletsFactoryService
  }
}

// MARK: - HasCreateWalletFactory
extension AppFactory: HasCreateWalletFactory {
  var createWalletFactory: CreateWalletFactoryProtocol {
    return createWalletFactoryService
  }
}

// MARK: - HasWalletDetailFactory
extension AppFactory: HasWalletDetailFactory {
  var walletDetailFactory: WalletDetailFactoryProtocol {
    return walletDetailFactoryService
  }
}

// MARK: - HasIncomeFactory
extension AppFactory: HasIncomeFactory {
  var incomeFactory: IncomeFactoryProtocol {
    return incomeFactoryService
  }
}

// MARK: - HasExpenseFactory
extension AppFactory: HasExpenseFactory {
  var expenseFactory: ExpenseFactoryProtocol {
    return expenseFactoryService
  }
}
