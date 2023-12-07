//
//  CustomCalculationViewViewModel.swift
//  WalletApp
//

import Foundation

final class ExpressionViewModel: SimpleViewStateProccessable {
  // MARK: - Properties
  var cellViewModels: [OperationCellViewModelProtocol] {
    return operations.compactMap { OperationCellViewModel($0) }
  }
  
  private(set) var viewState: Bindable<SimpleViewState<OperationModel>> = Bindable(.initial)
  private(set) var currentValue: Bindable<String> = Bindable("")
  private(set) var supprotingValue: Bindable<String> = Bindable("")
  private(set) var previousSign: Bindable<String> = Bindable("")
  
  private var operations: [OperationModel] {
    return viewState.value.currentEntities
  }
  
  private let wallet: WalletModel
  private let interactor: CalculationInteractorProtocol
  
  // MARK: - Init
  init(interactor: CalculationInteractorProtocol, wallet: WalletModel) {
    self.interactor = interactor
    self.wallet = wallet
  }
  
  // MARK: - Public methods
  func getOperations() {
    fetchOperations()
  }
  
  func updateOperations() {
    fetchOperations()
  }
  
  // MARK: - Private methods
  private func fetchOperations() {
    interactor.getOperations(for: wallet.id) { result in
      switch result {
      case .success(let operations):
        self.viewState.value = self.processResult(operations)
      case .failure(let error):
        print("Failed to fetch operations \(error)")
      }
    }
  }
}

// MARK: - CalculationViewViewModelDelegate
extension ExpressionViewModel: CalculationViewModelDelegate {
  func calculationViewModelDidRequestToUpdateAllValues(_ viewModel: CalculationViewModel, with supportingValue: String,
                                                       sign: String) {
    currentValue.value = ""
    supprotingValue.value = supportingValue
    previousSign.value = sign
  }
  
  func calculationViewModelDidRequestToUpdateAfterEqual(_ viewModel: CalculationViewModel, with currentValue: String) {
    self.currentValue.value = currentValue
    supprotingValue.value = ""
    previousSign.value = ""
  }
  
  func calculationViewModelDidRequestToUpdateCurrentValue(_ viewModel: CalculationViewModel, with value: String) {
    let oldValue: String = currentValue.value.withoutSpaces()
    let newValue = Double(oldValue + value) ?? 0
    
    if newValue.truncatingRemainder(dividingBy: 1) == 0 {
      let currenValue = Int(newValue).makeDigitSeparator()
      currentValue.value = currenValue
    } else {
      currentValue.value += value
    }
  }
}
