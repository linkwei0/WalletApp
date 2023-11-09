//
//  HistoryCellViewModel.swift
//  WalletApp
//

import Foundation

protocol OperationCellViewModelProtocol: TableCellViewModel {
  var name: String { get }
  var amount: String { get }
  var category: ExpenseCategoryType { get }
  var isIncome: Bool { get }
  var date: Date? { get }
}

protocol OperationCellViewModelDelegate: AnyObject {
  func operationCellViewModel(_ viewModel: OperationCellViewModel, didSelect operation: OperationModel)
}

class OperationCellViewModel: OperationCellViewModelProtocol {
  weak var delegate: OperationCellViewModelDelegate?
  
  var tableReuseIdentifier: String {
    return OperationItemCell.reuseIdentifiable
  }
  
  var name: String {
    return operation.name
  }
  
  var amount: String {
    return String(NSDecimalNumber(decimal: operation.amount).intValue)
  }
  
  var category: ExpenseCategoryType {
    return ExpenseCategoryType(rawValue: operation.category) ?? ExpenseCategoryType.food
  }
  
  var date: Date? {
    return operation.date
  }
  
  var isIncome: Bool {
    return operation.type.isIncome
  }
  
  private let operation: OperationModel
  
  init(_ operation: OperationModel) {
    self.operation = operation
  }
  
  func select() {
    delegate?.operationCellViewModel(self, didSelect: operation)
  }
}
