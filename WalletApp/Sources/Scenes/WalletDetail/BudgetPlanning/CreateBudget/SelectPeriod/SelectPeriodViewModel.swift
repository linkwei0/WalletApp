//
//  SelectPeriodViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 20.11.2023.
//

import Foundation

protocol SelectPeriodViewModelDelegate: AnyObject {
  func viewModelSuccessfullySelectedPeriod(_ viewModel: SelectPeriodViewModel, periodType: SelectPeriodTypes)
}

class SelectPeriodViewModel {
  // MARK: - Properties
  weak var delegate: SelectPeriodViewModelDelegate?
  
  var cellViewModels: [SelectPeriodCellViewModelProtocol] {
    return periodTypes.map { SelectPeriodCellViewModel($0) }
  }
  
  private let periodTypes: [SelectPeriodTypes] = SelectPeriodTypes.allCases
  
  // MARK: - Public methods
  func didSelectRow(at indexPath: IndexPath) {
    let periodType = periodTypes[indexPath.row]
    delegate?.viewModelSuccessfullySelectedPeriod(self, periodType: periodType)
  }
}
