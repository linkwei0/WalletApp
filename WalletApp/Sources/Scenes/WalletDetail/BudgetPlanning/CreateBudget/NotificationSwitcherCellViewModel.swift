//
//  NotificationSwitcherCellViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 23.11.2023.
//

import Foundation

protocol NotificationSwitcherCellViewModelDelegate: AnyObject {
  func cellViewModelDidChangeSwitcher(_ viewModel: NotificationSwitcherCellViewModel, isOn: Bool)
}

class NotificationSwitcherCellViewModel {
  // MARK: - Properties
  weak var delegate: NotificationSwitcherCellViewModelDelegate?
  
  // MARK: - Public methods
  func switcherDidChange(_ isOn: Bool) {
    delegate?.cellViewModelDidChangeSwitcher(self, isOn: isOn)
  }
}

// MARK: - TableCellViewModel
extension NotificationSwitcherCellViewModel: TableCellViewModel {
  var tableReuseIdentifier: String {
    return NotificationSwitcherCell.reuseIdentifiable
  }
}
