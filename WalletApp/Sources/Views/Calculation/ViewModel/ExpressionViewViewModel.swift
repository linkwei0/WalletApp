//
//  CustomCalculationViewViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 15.05.2023.
//

import Foundation

final class ExpressionViewViewModel {
  // MARK: - Properties
  
  private(set) var currentValue: Bindable<String> = Bindable("")
  private(set) var supprotingValue: Bindable<String> = Bindable("")
  private(set) var previousSign: Bindable<String> = Bindable("")
  
  // MARK: - Public methods
  
  func getOperations() {
    fetchOperations()
  }
  
  // MARK: - Private methods
  
  private func fetchOperations() {
    // TODO: - call to database
  }
}

// MARK: - CalculationViewViewModelDelegate

extension ExpressionViewViewModel: CalculationViewModelDelegate {
  func calculationViewModelDidRequestToUpdateValue(_ viewModel: CalculationViewModel, with value: String) {
    currentValue.value = value
  }
  
  func calculationViewModelDidRequestToUpdateAllValues(_ viewModel: CalculationViewModel,
                                                       with value: String, sign: String) {
    currentValue.value = ""
    supprotingValue.value = value
    previousSign.value = sign
  }
  
  func calculationViewModelDidRequestToUpdateAfterEqual(_ viewModel: CalculationViewModel, with value: String) {
    currentValue.value = value
    supprotingValue.value = ""
    previousSign.value = ""
  }
}
