//
//  HistoryCellViewModel.swift
//  WalletApp
//

import Foundation

protocol OperationCellViewModelProtocol: TableCellViewModel {
  var name: String { get }
  var amount: String { get }
  var category: CategoryTypesProtocol { get }
  var isIncome: Bool { get }
  var date: Date? { get }
}

protocol OperationCellViewModelDelegate: AnyObject {
  func operationCellViewModel(_ viewModel: OperationCellViewModel, didSelect operation: OperationModel)
}

class OperationCellViewModel: OperationCellViewModelProtocol {
  // MARK: - Properties
  weak var delegate: OperationCellViewModelDelegate?
  
  var tableReuseIdentifier: String {
    return OperationItemCell.reuseIdentifiable
  }
  
  var name: String {
    return operation.name
  }
  
  var amount: String {
    return NSDecimalNumber(decimal: operation.amount).intValue.makeDigitSeparator()
  }
  
  var category: CategoryTypesProtocol {
    if operation.type.isIncome {
      return IncomeCategoryTypes(rawValue: operation.category) ?? .salary
    } else {
      return ExpenseCategoryTypes(rawValue: operation.category) ?? ExpenseCategoryTypes.food
    }
  }
  
  var date: Date? {
    return operation.date
  }
  
  var isIncome: Bool {
    return operation.type.isIncome
  }
  
  private let operation: OperationModel
  
  // MARK: - Init
  init(_ operation: OperationModel) {
    self.operation = operation
  }
  
  // MARK: - Public methods
  func select() {
    delegate?.operationCellViewModel(self, didSelect: operation)
  }
}
