//
//  CustomCalculationViewViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 15.05.2023.
//

import Foundation

final class ExpressionViewViewModel {
  // MARK: - Properties
  
  var cellViewModels: [HistoryCellViewModelProtocol] {
    return histories.compactMap { HistoryCellViewModel($0) }
  }
  
  private var histories: [History] {
    return viewState.value.currentEntities
  }
  
  private(set) var viewState: Bindable<SimpleViewState<History>> = Bindable(.initial)
  private(set) var currentValue: Bindable<String> = Bindable("")
  private(set) var supprotingValue: Bindable<String> = Bindable("")
  private(set) var previousSign: Bindable<String> = Bindable("")
  
  // MARK: - Public methods
  
  func getHistories() {
    fetchHistories()
  }
  
  // MARK: - Private methods
  
  private func fetchHistories() {
    // TODO: - call to database
  }
}

// MARK: - CalculationViewViewModelDelegate

extension ExpressionViewViewModel: CalculationViewViewModelDelegate {
  func calculationViewModelDidRequestToUpdateValue(_ viewModel: CalculationViewViewModel, with value: String) {
    currentValue.value = value
  }
  
  func calculationViewModelDidRequestToUpdateAllValues(_ viewModel: CalculationViewViewModel,
                                                       with value: String, sign: String) {
    currentValue.value = ""
    supprotingValue.value = value
    previousSign.value = sign
  }
  
  func calculationViewModelDidRequestToUpdateAfterEqual(_ viewModel: CalculationViewViewModel, with value: String) {
    currentValue.value = value
    supprotingValue.value = ""
    previousSign.value = ""
  }
}
