//
//  HistoryCellViewModel.swift
//  WalletApp
//

import UIKit

protocol OperationCellViewModelProtocol {
  var name: String { get }
  var tintColor: UIColor { get }
  var date: Date? { get }
}

class OperationCellViewModel: OperationCellViewModelProtocol {
  var tintColor: UIColor {
    return UIColor.baseWhite
  }
  
  let name: String
  let date: Date?
  
  init(_ operation: OperationModel) {
    self.name = operation.name
    self.date = operation.date
  }
}
