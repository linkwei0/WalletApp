//
//  OperationDefaultFooterViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 08.11.2023.
//

import Foundation

protocol OperationDefaultFooterViewModelDelegate: AnyObject {
  func defaultFooterViewModelDidTapMoreOperations(_ viewModel: OperationDefaultFooterViewModel)
}

class OperationDefaultFooterViewModel {
  weak var delegate: OperationDefaultFooterViewModelDelegate?
  
  func didTapMoreOperations() {
    delegate?.defaultFooterViewModelDidTapMoreOperations(self)
  }
}

// MARK: - TableFooterViewModel
extension OperationDefaultFooterViewModel: TableFooterViewModel {
  var tableReuseIdentifier: String {
    return String(describing: OperationDefaultFooterView.reuseIdentifiable)
  }
}
