//
//  TestDetailCellViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 28.11.2023.
//

import Foundation

class WalletDetailCellViewModel: TableViewModel {
  // MARK: - Properties
  var date: String {
    return dateType.title
  }
  
  var amountOfDay: String {
    let totalAmount = amountOfDateOperations >= isPositiveNumbers ? "+\(amountOfDateOperations.makeDigitSeparator())"
    : "-\(amountOfDateOperations.makeDigitSeparator())"
    return totalAmount
  }
  
  var moreButtonTitle: String {
    return R.string.walletDetail.defaultFooterViewTitle()
  }
  
  var sectionViewModels: [TableSectionViewModel] {
    let cellViewModels = operations.map { operation in
      let operationValue = NSDecimalNumber(decimal: operation.amount).intValue
      amountOfDateOperations = operation.type.isIncome ? amountOfDateOperations + operationValue
      : amountOfDateOperations - operationValue
      let cellViewModel = OperationCellViewModel(operation)
      return cellViewModel
    }
    let section = TableSectionViewModel()
    section.append(cellViewModels: cellViewModels)
    return [section]
  }
  
  private var amountOfDateOperations: Int = 0
  
  private let isPositiveNumbers: Int = 0
  
  private let operations: [OperationModel]
  private let dateType: OperationDateType
  
  // MARK: - Init
  init(operations: [OperationModel], dateType: OperationDateType) {
    self.operations = operations
    self.dateType = dateType
  }
}

// MARK: - TableCellViewModel
extension WalletDetailCellViewModel: TableCellViewModel {
  var tableReuseIdentifier: String {
    return WalletDetailCell.reuseIdentifiable
  }
  
  func select(indexPath: IndexPath) {
    print("Selected \(operations[indexPath.row])")
  }
}
