//
//  CalculationModalViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 16.11.2023.
//

import Foundation

protocol CalculationModalViewModelDelegate: AnyObject {
  func viewModelDidRequestToChangeAmount(_ viewModel: CalculationModalViewModel, amount: String)
  func viewModelDidRequestToPreviousValue(_ viewModel: CalculationModalViewModel)
  func viewModelDidToRequestPoint(_ viewModel: CalculationModalViewModel)
}

class CalculationModalViewModel {
  // MARK: - Properties
  weak var delegate: CalculationModalViewModelDelegate?
  
  private let modalBottomCalculation: [[ModalCalculationViewTypes]] = [
    [.seven, .eight, .nine],
    [.four, .five, .six],
    [.one, .two, .three],
    [.point, .zero, .previousValue]
  ]
  
  // MARK: - Public methods
  func numberOfSections() -> Int {
    return modalBottomCalculation.count
  }
  
  func numberOfRowsInSection(section: Int) -> Int {
    return modalBottomCalculation[section].count
  }
  
  func configureCellViewModel(at indexPath: IndexPath) -> ModalCalculationCellViewModel {
    let cellViewModel = ModalCalculationCellViewModel(type: modalBottomCalculation[indexPath.section][indexPath.row])
    cellViewModel.delegate = self
    return cellViewModel
  }
}

// MARK: - ElementCollectionCellViewModelDelegate
extension CalculationModalViewModel: ModalCalculationCellViewModelDelegate {
  func cellViewModelDidSelect(_ viewModel: ModalCalculationCellViewModel, type: ModalCalculationViewTypes) {
    switch type {
    case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
      self.delegate?.viewModelDidRequestToChangeAmount(self, amount: type.stringValue)
    case .point:
      self.delegate?.viewModelDidToRequestPoint(self)
    case .previousValue:
      self.delegate?.viewModelDidRequestToPreviousValue(self)
    }
  }
}
