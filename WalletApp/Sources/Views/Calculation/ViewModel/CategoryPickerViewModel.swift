//
//  CategoryPickerViewModel.swift
//  WalletApp
//

import Foundation

class CategoryPickerViewModel {
  // MARK: - Properties
  var onDidCreatedOperation: ((_ wallet: WalletModel) -> Void)?
  
  private(set) var totalValue: Bindable<String> = Bindable("")
  private(set) var isCreateOperation: Bindable<Bool> = Bindable(false)
  
  private let categories: [[CategoryType]] =
  [
    [.food, .house, .car],
    [.phone, .transport]
  ]
  
  private var wallet: WalletModel
  
  private let interactor: CalculationInteractorProtocol
  private let calculationType: CalculationType
  
  // MARK: - Init
  init(interactor: CalculationInteractorProtocol, wallet: WalletModel, totalValue: String, calculationType: CalculationType) {
    self.interactor = interactor
    self.wallet = wallet
    self.totalValue.value = totalValue
    self.calculationType = calculationType
  }
  
  // MARK: - Public methods
  func numberOfSections() -> Int {
    return categories.count
  }
  
  func numberOfItemsInSection(section: Int) -> Int {
    return categories[section].count
  }
  
  func configureItemType(_ indexPath: IndexPath) -> CategoryCellViewModel {
    let categoryType = categories[indexPath.section][indexPath.row]
    let cellViewModel = CategoryCellViewModel(categoryType: categoryType)
    return cellViewModel
  }
  
  func didSelectedCategory(at indexPath: IndexPath) {
    guard let amount = Decimal(string: totalValue.value) else { return }
    let type = (CalculationType(rawValue: calculationType.rawValue) ?? .income).rawValue
    let category = categories[indexPath.section][indexPath.row]
    let operation = OperationModel(id: UUID().hashValue, walletId: wallet.id, name: category.title,
                                   amount: amount, category: category.title, date: Date(),
                                   type: OperationType(rawValue: type) ?? .income)
    checkOperationType(for: operation)
    createOperationAtPersistence(operation)
  }
  
  // MARK: - Private methods
  private func checkOperationType(for operation: OperationModel) {
    if calculationType == .income {
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
        self.onDidCreatedOperation?(self.wallet)
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
