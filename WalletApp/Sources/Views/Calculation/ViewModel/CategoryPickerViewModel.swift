//
//  CategoryPickerViewModel.swift
//  WalletApp
//

import Foundation

protocol CategoryPickerViewModelDelegate: AnyObject {
  func viewModelDidRequestToNotificationUser(_ viewModel: CategoryPickerViewModel, title: String, subtitle: String)
}

class CategoryPickerViewModel {
  // MARK: - Properties
  weak var delegate: CategoryPickerViewModelDelegate?
  
  var onNeedsToUpdateOperation: ((_ wallet: WalletModel, _ operation: OperationModel) -> Void)?
  var onNeedsToUpdateAmountLabel: ((String) -> Void)?
  var onNeedsToDismissController: (() -> Void)?
    
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
  
  private let walletBalanceBound: Decimal = 0
  
  private let interactor: CalculationInteractorProtocol
  private let operationType: OperationType
  
  // MARK: - Init
  init(interactor: CalculationInteractorProtocol, wallet: WalletModel, operation: OperationModel) {
    self.interactor = interactor
    self.wallet = wallet
    self.operation = operation
    self.operationType = operation.type
  }
  
  // MARK: - Public methods
  func viewIsReady() {
    getAmountValue()
  }
  
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
      onNeedsToDismissController?()
    }
  }
  
  // MARK: - Private methods
  private func getAmountValue() {
    let currencySign = (CurrencyModelView.WalletsCurrencyType(rawValue: wallet.currency.code) ?? .rub).title
    let amountValue = NSDecimalNumber(decimal: operation.amount).intValue.makeDigitSeparator()
    onNeedsToUpdateAmountLabel?(amountValue + " " + currencySign)
  }
  
  private func changeWalletBalance(with operation: OperationModel) {
    if operationType.isIncome {
      wallet.balance += operation.amount
      wallet.totalEarned += operation.amount
    } else {
      if operation.amount.isLess(than: wallet.balance) {
        wallet.balance -= operation.amount
        wallet.totalSpent += operation.amount
        if wallet.balance.isLess(than: walletBalanceBound) {
          wallet.balance = walletBalanceBound
        }
      } else {
        wallet.balance = walletBalanceBound
        wallet.totalSpent += operation.amount
      }
    }
  }
  
  private func createOperationAtPersistence(_ operation: OperationModel) {
    let walletPreviousBalance = wallet.balance
    let walletPreviousTotalEarned = wallet.totalEarned
    let walletPreviousTotalSpent = wallet.totalSpent
    
    interactor.saveOperation(for: wallet, operation: operation) { result in
      switch result {
      case .success:
        self.updateWalletBudgets(with: operation)
        self.onNeedsToUpdateOperation?(self.wallet, operation)
        self.onNeedsToDismissController?()
      case .failure(let error):
        self.wallet.balance = walletPreviousBalance
        self.wallet.totalEarned = walletPreviousTotalEarned
        self.wallet.totalSpent = walletPreviousTotalSpent
        print("Failed to save operation for \(self.wallet.id) with \(error)")
      }
    }
  }
  
  private func updateWalletBudgets(with operation: OperationModel) {
    interactor.updateBudgets(for: wallet.id, with: operation) { result in
      switch result {
      case .success(let budget):
        if let budget = budget {
          self.delegate?.viewModelDidRequestToNotificationUser(self, 
                                                               title: R.string.categoryPicker.categoryPickerNotificationTitle(),
                                                               subtitle: "\("'\(budget.name)'")" +
                                                               R.string.categoryPicker.categoryPickerNotificationSubtitle())
        }
      case .failure(let error):
        print("Failed to update budget after operation with \(error)")
      }
    }
  }
}
