//
//  CategoryPickerViewModel.swift
//  WalletApp
//

import Foundation

class CategoryPickerViewModel {
  // MARK: - Properties
  var onNeedsToUpdateOperation: ((_ wallet: WalletModel, _ operation: OperationModel) -> Void)?
  
  private(set) var operationAmountValue: Bindable<String> = Bindable("")
  private(set) var isCreateOperation: Bindable<Bool> = Bindable(false)
  
  private let expenseCategories: [[ExpenseCategoryTypes]] =
  [
    [.food, .house, .car],
    [.phone, .transport]
  ]
  
  private let incomeCategories: [[IncomeCategoryTypes]] =
  [
    [.present, .salary, .partjob],
    [.dividends]
  ]
  
  private var wallet: WalletModel
  private var operation: OperationModel
  
  private let interactor: CalculationInteractorProtocol
  private let operationType: OperationType
  
  // MARK: - Init
  init(interactor: CalculationInteractorProtocol, wallet: WalletModel, operation: OperationModel) {
    self.interactor = interactor
    self.wallet = wallet
    self.operation = operation
    self.operationAmountValue.value = NSDecimalNumber(decimal: operation.amount).stringValue
    + (CurrencyModelView.WalletsCurrencyType(rawValue: wallet.currency.code) ?? .rub).title
    self.operationType = operation.type
  }
  
  // MARK: - Public methods
  func numberOfSections() -> Int {
    return operationType.isIncome ? incomeCategories.count : expenseCategories.count
  }
  
  func numberOfItemsInSection(section: Int) -> Int {
    return operationType.isIncome ? incomeCategories[section].count : expenseCategories[section].count
  }
  
  func configureItemType(_ indexPath: IndexPath) -> CategoryCellViewModel {
    let categoryType: CategoryTypesProtocol = operationType.isIncome ? incomeCategories[indexPath.section][indexPath.row]
    : expenseCategories[indexPath.section][indexPath.row]
    let cellViewModel = CategoryCellViewModel(categoryType: categoryType)
    return cellViewModel
  }
  
  func didSelectedCategory(at indexPath: IndexPath) {
    let category: CategoryTypesProtocol = operationType.isIncome ? incomeCategories[indexPath.section][indexPath.row]
    : expenseCategories[indexPath.section][indexPath.row]
    changeWalletBalance(with: operation)

    if operation.category.isEmpty {
      operation.name = category.title
      operation.category = category.title
      createOperationAtPersistence(operation)
    } else {
      operation.name = category.title
      operation.category = category.title
      onNeedsToUpdateOperation?(wallet, operation)
      isCreateOperation.value = true
    }
  }
  
  // MARK: - Private methods
  private func changeWalletBalance(with operation: OperationModel) {
    if operationType.isIncome {
      wallet.balance += operation.amount
      wallet.totalEarned += operation.amount
    } else {
      wallet.balance -= operation.amount
      wallet.totalSpent += operation.amount
    }
  }
  
  private func createOperationAtPersistence(_ operation: OperationModel) {
    let walletPreviousBalance = wallet.balance
    let walletPreviousTotalEarned = wallet.totalEarned
    let walletPreviousTotalSpent = wallet.totalSpent
    
    interactor.saveOperation(for: wallet, operation: operation) { result in
      switch result {
      case .success:
        self.onNeedsToUpdateOperation?(self.wallet, operation)
        self.isCreateOperation.value = true
      case .failure(let error):
        self.wallet.balance = walletPreviousBalance
        self.wallet.totalEarned = walletPreviousTotalEarned
        self.wallet.totalSpent = walletPreviousTotalSpent
        print("Failed to save operation for \(self.wallet.id) with \(error)")
      }
    }
  }
}
