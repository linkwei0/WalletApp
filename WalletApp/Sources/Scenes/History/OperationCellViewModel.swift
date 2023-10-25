//
//  HistoryCellViewModel.swift
//  WalletApp
//

import Foundation

protocol OperationCellViewModelProtocol {
  var name: String { get }
  var amount: String { get }
  var date: Date? { get }
}

class OperationCellViewModel: OperationCellViewModelProtocol {
  var name: String {
    return operation.name
  }
  
  var amount: String {
    return NSDecimalNumber(decimal: operation.amount).stringValue
  }
  
  var date: Date? {
    return operation.date
  }
  
  private let operation: OperationModel
  
  init(_ operation: OperationModel) {
    self.operation = operation
  }
}
