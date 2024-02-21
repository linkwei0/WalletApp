//
//  AppFactory.swift
//  WalletApp
//

import Foundation

// MARK: - Protocols
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

protocol HasOperationEditFactory {
  var operationEditFactory: OperationEditFactoryProtocol { get }
}

protocol HasProfileFactory {
  var profileFactory: ProfileFactoryProtocol { get }
}

protocol HasUseCaseProviderFactory {
  var useCaseProviderFactory: UseCaseProviderFactoryProtocol { get }
}

protocol HasOperationListFactory {
  var operationListFactory: OperationListFactoryProtocol { get }
}

protocol HasBudgetPlanningFactory {
  var budgetPlanningFactory: BudgetPlanningFactoryProtocol { get }
}

protocol HasCreateBudgetFactory {
  var createBudgetFactory: CreateBudgetFactoryProtocol { get }
}

protocol HasBudgetDetailFactory {
  var budgetDetailFactory: BudgetDetailFactoryProtocol { get }
}

protocol HasCardDetailFactory {
  var cardDetailFactory: CardDetailFactoryProtocol { get }
}

final class AppFactory {
  // MARK: - DI
  private let walletsFactoryService: WalletsFactory
  private let createWalletFactoryService: CreateWalletFactory
  private let walletDetailFactoryService: WalletDetailFactory
  private let incomeFactoryService: IncomeFactory
  private let expenseFactoryService: ExpenseFactory
  private let operationEditFactoryService: OperationEditFactory
  private let profileFactoryService: ProfileFactory
  private let operationListFactoryService: OperationListFactory
  private let budgetPlanningFactoryService: BudgetPlanningFactory
  private let createBudgetFactoryService: CreateBudgetFactory
  private let budgetDetailFactoryService: BudgetDetailFactory
  private let cardDetailFactoryService: CardDetailFactory
  
  private let useCaseProviderFacotryService = UseCaseProviderFactory()
  
  // MARK: - Init
  init() {
    let useCaseProvider = useCaseProviderFacotryService.makeUseCaseProvider()
    
    walletsFactoryService = WalletsFactory(useCaseProvider: useCaseProvider)
    createWalletFactoryService = CreateWalletFactory(useCaseProvider: useCaseProvider)
    walletDetailFactoryService = WalletDetailFactory(useCaseProvider: useCaseProvider)
    incomeFactoryService = IncomeFactory(useCaseProvider: useCaseProvider)
    expenseFactoryService = ExpenseFactory(useCaseProvider: useCaseProvider)
    operationEditFactoryService = OperationEditFactory(useCaseProvider: useCaseProvider)
    profileFactoryService = ProfileFactory(useCaseProvider: useCaseProvider)
    operationListFactoryService = OperationListFactory()
    budgetPlanningFactoryService = BudgetPlanningFactory(useCaseProvider: useCaseProvider)
    createBudgetFactoryService = CreateBudgetFactory(useCaseProvider: useCaseProvider)
    budgetDetailFactoryService = BudgetDetailFactory()
    cardDetailFactoryService = CardDetailFactory()
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

// MARK: - HasOperationEditFactory
extension AppFactory: HasOperationEditFactory {
  var operationEditFactory: OperationEditFactoryProtocol {
    return operationEditFactoryService
  }
}

// MARK: - HasProfileFactory
extension AppFactory: HasProfileFactory {
  var profileFactory: ProfileFactoryProtocol {
    return profileFactoryService
  }
}

// MARK: - HasUseCaseProviderFactory
extension AppFactory: HasUseCaseProviderFactory {
  var useCaseProviderFactory: UseCaseProviderFactoryProtocol {
    return useCaseProviderFacotryService
  }
}

// MARK: - HasOperationListFactory
extension AppFactory: HasOperationListFactory {
  var operationListFactory: OperationListFactoryProtocol {
    return operationListFactoryService
  }
}

// MARK: - HasBudgetPlanningFactory
extension AppFactory: HasBudgetPlanningFactory {
  var budgetPlanningFactory: BudgetPlanningFactoryProtocol {
    return budgetPlanningFactoryService
  }
}

// MARK: - HasCreateBudgetFactory
extension AppFactory: HasCreateBudgetFactory {
  var createBudgetFactory: CreateBudgetFactoryProtocol {
    return createBudgetFactoryService
  }
}

// MARK: - HasBudgetDetailFactory
extension AppFactory: HasBudgetDetailFactory {
  var budgetDetailFactory: BudgetDetailFactoryProtocol {
    return budgetDetailFactoryService
  }
}

// MARK: - HasCardDetailFactory
extension AppFactory: HasCardDetailFactory {
  var cardDetailFactory: CardDetailFactoryProtocol {
    return cardDetailFactoryService
  }
}
