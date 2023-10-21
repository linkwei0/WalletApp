//
//  CustomCalculationViewViewModel.swift
//  WalletApp
//

import Foundation

final class ExpressionViewModel: SimpleViewStateProcessable {
  // MARK: - Properties
  private(set) var viewState: Bindable<SimpleViewState<OperationModel>> = Bindable(.initial)
  private(set) var currentValue: Bindable<String> = Bindable("")
  private(set) var supprotingValue: Bindable<String> = Bindable("")
  private(set) var previousSign: Bindable<String> = Bindable("")
  
  private let interactor: CalculationInteractorProtocol
  
  // MARK: - Init
  init(interactor: CalculationInteractorProtocol) {
    self.interactor = interactor
  }
  
  // MARK: - Public methods
  func getOperations() {
    fetchOperations()
  }
  
  // MARK: - Private methods
  private func fetchOperations() {
    interactor.getOperations { result in
      switch result {
      case .success(let operations):
        self.viewState.value = self.processResult(operations)
      case .failure(let error):
        print("Failed to fetch operations")
      }
    }
  }
}

// MARK: - CalculationViewViewModelDelegate
extension ExpressionViewModel: CalculationViewModelDelegate {
  func calculationViewModelDidRequestToUpdateValue(_ viewModel: CalculationViewModel, with value: String) {
    if value.count <= 7 {
      currentValue.value = value
    }
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
