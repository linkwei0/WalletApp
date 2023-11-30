//
//  TestDetailCellViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 28.11.2023.
//

import Foundation

protocol WalletDetailCellViewModelDelegate: AnyObject {
  func cellViewModelDidSelect(_ viewModel: WalletDetailCellViewModel, didSelect operation: OperationModel)
  func cellViewModelDidRequestToShowMoreOperations(_ viewModel: WalletDetailCellViewModel)
}

class WalletDetailCellViewModel: TableViewModel {
  // MARK: - Properties
  weak var delegate: WalletDetailCellViewModelDelegate?
  
  var isEmpty: Bool {
    return operations.isEmpty
  }
  
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
      let cellViewModel = OperationCellViewModel(operation)
      cellViewModel.delegate = self
      return cellViewModel
    }
    let section = TableSectionViewModel()
    section.append(cellViewModels: cellViewModels)
    return [section]
  }
  
  private var amountOfDateOperations: Int {
    var amount: Decimal = 0
    operations.forEach { amount += $0.amount }
    return NSDecimalNumber(decimal: amount).intValue
  }
  
  private let isPositiveNumbers: Int = 0
  
  private let operations: [OperationModel]
  private let dateType: OperationDateType
  
  // MARK: - Init
  init(operations: [OperationModel], dateType: OperationDateType) {
    self.operations = operations
    self.dateType = dateType
  }
  
  // MARK: - Public methods
  func didTapShowMoreButton() {
    delegate?.cellViewModelDidRequestToShowMoreOperations(self)
  }
}

// MARK: - TableCellViewModel
extension WalletDetailCellViewModel: TableCellViewModel {
  var tableReuseIdentifier: String {
    return WalletDetailCell.reuseIdentifiable
  }
}

// MARK: - OperationCellViewModelDelegate
extension WalletDetailCellViewModel: OperationCellViewModelDelegate {
  func operationCellViewModel(_ viewModel: OperationCellViewModel, didSelect operation: OperationModel) {
    delegate?.cellViewModelDidSelect(self, didSelect: operation)
  }
}
