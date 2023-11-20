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
  
  private let calculation: [[CalculationModalViewType]] = [
    [.seven, .eight, .nine],
    [.four, .five, .six],
    [.one, .two, .three],
    [.point, .zero, .previousValue]
  ]
  
  // MARK: - Public methods
  func numberOfSections() -> Int {
    return calculation.count
  }
  
  func numberOfRowsInSection(section: Int) -> Int {
    return calculation[section].count
  }
  
  func configureCellViewModel(at indexPath: IndexPath) -> ElementCollectionCellViewModel {
    let cellViewModel = ElementCollectionCellViewModel(type: calculation[indexPath.section][indexPath.row])
    cellViewModel.delegate = self
    return cellViewModel
  }
}

// MARK: - ElementCollectionCellViewModelDelegate
extension CalculationModalViewModel: ElementCollectionCellViewModelDelegate {
  func cellViewModelDidSelect(_ viewModel: ElementCollectionCellViewModel, type: CalculationModalViewType) {
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
