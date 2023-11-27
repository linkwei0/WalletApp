//
//  BudgetLocalDataSource.swift
//  WalletApp
//
//  Created by Артём Бацанов on 21.11.2023.
//

import CoreData

class BudgetLocalDataSource: BudgetLocalDataSourceProtocol {
  private let coreDataStack: CoreDataStack
  
  init(coreDataStack: CoreDataStack) {
    self.coreDataStack = coreDataStack
  }
  
  func getBudgets(for walletID: Int, completion: @escaping (Result<[BudgetModel], Error>) -> Void) {
    let budgets = coreDataStack.getObjectByValue(columnName: #keyPath(CDBudget.walletID), value: String(walletID),
                                                 type: CDBudget.self)
    completion(.success(budgets.compactMap { $0.makeDomain() }))
  }
  
  func saveBudget(for walletID: Int, budget: BudgetModel, completion: @escaping (Result<Void, Error>) -> Void) {
    guard let currentWallet = coreDataStack.getObjectByValue(columnName: "id", value: String(walletID),
                                                             type: CDWallet.self,
                                                             context: coreDataStack.writeContext).first else { return }
    if currentWallet.budgets?.count ?? 0 > 3 { return }
    guard let budgetCD = budget.makePersistent(context: coreDataStack.writeContext) else { return }
    currentWallet.addToBudgets(budgetCD)
    
    do {
      try coreDataStack.saveWriteContext()
      completion(.success(Void()))
    } catch {
      completion(.failure(error))
    }
  }
    
  func updateBudget(for walletID: Int, with operation: OperationModel, 
                    completion: @escaping (Result<BudgetModel?, Error>) -> Void) {
    let budgets = coreDataStack.getObjectByValue(columnName: #keyPath(CDBudget.walletID), value: String(walletID),
                                                 type: CDBudget.self, context: coreDataStack.writeContext)
    
    var budgetModel: BudgetModel?
    budgets.filter { $0.isNotifiable && $0.category == operation.category }.forEach { budget in
      if let maxAmount = budget.maxAmount?.decimalValue, let currentAmount = budget.currentAmount?.decimalValue {
        if maxAmount <= currentAmount { budgetModel = budget.makeDomain() }
      }
    }
    
    do {
      try coreDataStack.saveWriteContext()
      completion(.success(budgetModel))
    } catch {
      print("Failed to save operation in budgets with error \(error)")
      completion(.failure(error))
    }
  }
}
