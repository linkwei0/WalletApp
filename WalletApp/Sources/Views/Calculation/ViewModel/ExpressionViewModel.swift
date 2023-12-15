//
//  CustomCalculationViewViewModel.swift
//  WalletApp
//

import Foundation

final class ExpressionViewModel: TableViewModel { //: SimpleViewStateProccessable {
  // MARK: - Properties
  var onNeedsToUpdateTableView: (() -> Void)?
  
  var currentValue: String {
    return visibleCurrentValue.value.withoutSpaces()
  }
  
  var previousValue: String {
    return visiblePreviousValue.value.withoutSpaces()
  }
  
  var sign: String {
    return visibleSign.value
  }
  
  private(set) var sectionViewModels: [TableSectionViewModel] = []
  
  private(set) var visibleCurrentValue: Bindable<String> = Bindable("")
  private(set) var visiblePreviousValue: Bindable<String> = Bindable("")
  private(set) var visibleSign: Bindable<String> = Bindable("")
  
  private var operations: [OperationModel] = []
  private var cellViewModels: [TableCellViewModel] = []
  
  private var currentValueIsFractional = false
  
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
        self.operations = operations
        self.operationsSortedByDate(with: operations)
      case .failure(let error):
        print("Failed to fetch operations \(error)")
      }
    }
  }
  
  private func operationsSortedByDate(with operations: [OperationModel]) {
    sectionViewModels.removeAll()
    
    var operationsDateDict: [DateInterval: [OperationCellViewModel]] = [:]
    operations.forEach { operation in
      let itemViewModel = OperationCellViewModel(operation)
      let dateInterval = operation.date.dateInterval()
      
      if let value = operationsDateDict[dateInterval] {
        operationsDateDict[dateInterval] = value + [itemViewModel]
      } else {
        operationsDateDict[dateInterval] = [itemViewModel]
      }
    }
    
    let dateFormatter = DateFormatter.dayMonthYearDisplay
    let sortedDateInterval: [DateInterval] = Array(operationsDateDict.keys).sorted(by: >)
    for dateInterval in sortedDateInterval {
      if operationsDateDict[dateInterval]?.isEmpty == false {
        let headerOperationDate = dateFormatter.string(from: dateInterval.start)
        let headerViewModel = OperationDateHeaderViewModel(operationDate: headerOperationDate, type: .common)
        let section = TableSectionViewModel(headerViewModel: headerViewModel)
        section.append(cellViewModels: operationsDateDict[dateInterval] ?? [])
        sectionViewModels.append(section)
      }
    }
    onNeedsToUpdateTableView?()
  }
}

// MARK: - CalculationViewViewModelDelegate
extension ExpressionViewModel: CalculationViewModelDelegate {
  func viewModelDidRequestToUpdateAllValues(_ viewModel: CalculationViewModel, currentValue: String,
                                            prevValue: String, sign: String) {
    visibleCurrentValue.value = currentValue.makeSpaces()
    visiblePreviousValue.value = prevValue.makeSpaces()
    visibleSign.value = sign
    currentValueIsFractional = false
  }
  
  func viewModelDidRequestToShowResult(_ viewModel: CalculationViewModel, _ result: String) {
    visibleCurrentValue.value = currentValueIsFractional ? result : result.makeSpaces()
    visiblePreviousValue.value = ""
    visibleSign.value = ""
  }
  
  func viewModelDidRequestToAddNewNumber(_ viewModel: CalculationViewModel, with value: String) {
    if !currentValueIsFractional {
      let oldValue: String = visibleCurrentValue.value.withoutSpaces()
      let newValue = Double(oldValue + value) ?? 0
      
      if newValue.truncatingRemainder(dividingBy: 1) == 0 {
        let currenValue = Int(newValue).makeDigitSeparator()
        visibleCurrentValue.value = currenValue
      } else {
        visibleCurrentValue.value += value
      }
    } else {
      visibleCurrentValue.value += value
    }
  }
  
  func viewModelDidRequestToUpdateFractionalStatus(_ viewModel: CalculationViewModel, isFractional: Bool) {
    currentValueIsFractional = isFractional
  }
  
  func viewModelDidRequestToToggleSign(_ viewModel: CalculationViewModel, _ currentValue: String) {
    visibleCurrentValue.value = currentValue.makeSpaces()
  }
  
  func viewModelDidRequestToDropLastNumber(_ viewModel: CalculationViewModel) {
    let updatedValue = String(currentValue.dropLast())
    visibleCurrentValue.value = updatedValue.makeSpaces()
  }
}
