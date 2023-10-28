//
//  CategoryPickerViewModel.swift
//  WalletApp
//

import Foundation

class CategoryPickerViewModel {
  // MARK: - Properties
  var onDidCreatedOperation: (() -> Void)?
  
  private(set) var totalValue: Bindable<String> = Bindable("")
  private(set) var isCreateOperation: Bindable<Bool> = Bindable(false)
  
  private let categories: [[CategoryType]] =
  [
    [.food, .house, .car],
    [.phone, .transport]
  ]
  
  private let interactor: CalculationInteractorProtocol
  private let wallet: WalletModel
  
  // MARK: - Init
  init(interactor: CalculationInteractorProtocol, wallet: WalletModel, totalValue: String) {
    self.interactor = interactor
    self.wallet = wallet
    self.totalValue.value = totalValue
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
    let category = categories[indexPath.section][indexPath.row]
    let operation = OperationModel(id: UUID().hashValue, walletId: wallet.id, name: category.title,
                                   amount: amount, category: category.title, date: Date(), type: .income)
    interactor.saveOperation(for: wallet.id, operation: operation) { result in
      switch result {
      case .success:
        self.onDidCreatedOperation?()
        self.isCreateOperation.value = true
      case .failure(let error):
        print("Failed to save operation for \(self.wallet.id) with \(error)")
      }
    }
  }
}
