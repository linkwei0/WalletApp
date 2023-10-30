//
//  HistoryCellViewModel.swift
//  WalletApp
//

import Foundation

protocol OperationCellViewModelProtocol: TableCellViewModel {
  var name: String { get }
  var amount: String { get }
  var category: CategoryType { get }
  var isIncome: Bool { get }
  var date: Date? { get }
}

class OperationCellViewModel: OperationCellViewModelProtocol {
  var tableReuseIdentifier: String {
    return OperationItemCell.reuseIdentifiable
  }
  
  var name: String {
    return operation.name
  }
  
  var amount: String {
    return NSDecimalNumber(decimal: operation.amount).stringValue
  }
  
  var category: CategoryType {
    return CategoryType(rawValue: operation.category) ?? CategoryType.food
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
}
