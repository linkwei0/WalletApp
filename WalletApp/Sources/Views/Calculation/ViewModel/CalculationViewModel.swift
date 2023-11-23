//
//  CalculationViewViewModel.swift
//  WalletApp
//

import Foundation

protocol CalculationViewModelDelegate: AnyObject {
  func calculationViewModelDidRequestToUpdateAllValues(_ viewModel: CalculationViewModel, with supprtingValue: String,
                                                       sign: String)
  func calculationViewModelDidRequestToUpdateAfterEqual(_ viewModel: CalculationViewModel, with value: String)
}

protocol CalculationViewModelCategoryDelegate: AnyObject {
  func calculationViewModelDidRequestToShowCategoryView(_ viewModel: CalculationViewModel, wallet: WalletModel,
                                                        operation: OperationModel)
}

final class CalculationViewModel: SimpleViewStateProccessable {
  // MARK: - Properties
  private enum Sign: String {
    case minus = "-", plus = "+", multiply = "x", divide = "/"
  }
  
  weak var delegate: CalculationViewModelDelegate?
  weak var calculationCategoryDelegate: CalculationViewModelCategoryDelegate?
  
  let expressionViewModel: ExpressionViewModel
  
  private(set) var operationType: CollectionType
  private(set) var calculationButtons: [[CalculationItemType]] =
  [
    [.resetValues, .plusMinus, .percent, .divide],
    [.seven, .eight, .nine, .multiply],
    [.four, .five, .six, .minus],
    [.one, .two, .three, .plus],
    [.previousValue, .zero, .point, .equal]
  ]
  
  private let maxNumberLength: Int = 7
  
  private let wallet: WalletModel
  private let interactor: CalculationInteractorProtocol
  
  // MARK: - Init
  init(interactor: CalculationInteractorProtocol, wallet: WalletModel, collectionType: CollectionType) {
    self.interactor = interactor
    self.wallet = wallet
    self.operationType = collectionType
    self.expressionViewModel = ExpressionViewModel(interactor: interactor, wallet: wallet)
    delegate = expressionViewModel
  }
  
  // MARK: - Public methods
  func configureItemType(_ indexPath: IndexPath) -> CalculationCellViewModel {
    let itemType = calculationButtons[indexPath.section][indexPath.row]
    let cellViewModel = CalculationCellViewModel(collectionType: operationType, itemType: itemType)
    cellViewModel.delegate = self
    return cellViewModel
  }
  
  func numberOfSections() -> Int {
    return calculationButtons.count
  }
  
  func numberOfRowsInSection(at section: Int) -> Int {
    return calculationButtons[section].count
  }
  
  func didTapCreateOperationButton() {
    guard !expressionViewModel.currentValue.value.isEmpty else { return }
    let operationType: OperationType = operationType == .income ? .income : .expense
    let operation = OperationModel(id: UUID().hashValue, walletId: wallet.id, name: "",
                                   amount: Decimal(string: expressionViewModel.currentValue.value) ?? 0, category: "",
                                   date: Date(), type: operationType)
    calculationCategoryDelegate?.calculationViewModelDidRequestToShowCategoryView(self, wallet: wallet, operation: operation)
  }
  
  func updateOperations() {
    expressionViewModel.currentValue.value = ""
    expressionViewModel.supprotingValue.value = ""
    expressionViewModel.previousSign.value = ""
    expressionViewModel.updateOperations()
  }
  
  // MARK: - Private methods
  private func handleTappedCalculatorButton(with itemType: CalculationItemType) {
    if expressionViewModel.currentValue.value.count <= maxNumberLength {
      if itemType.isNumber {
        expressionViewModel.currentValue.value += itemType.stringValue
      }
      
      if itemType.isSign && !expressionViewModel.currentValue.value.isEmpty {
        let resultValue = handleTappedArithmeticSign()
        delegate?.calculationViewModelDidRequestToUpdateAllValues(self, with: resultValue, sign: itemType.stringValue)
      }
      
      if itemType.isPoint {
        handleTappedPointSign()
      }
      
      if itemType.isEqual {
        let resultValue = handleTappedArithmeticSign()
        handleTappedEqualSign(resultValue)
      }
    }
  }
  
  private func handleTappedArithmeticSign() -> String {
    var resultValue: Double
    let supportingValue = Double(expressionViewModel.supprotingValue.value) ?? 0
    let currentValue = Double(expressionViewModel.currentValue.value) ?? 0
    let sign = Sign(rawValue: expressionViewModel.previousSign.value) ?? .plus
    
    switch sign {
    case .plus:
      resultValue = supportingValue + currentValue
    case .minus:
      resultValue = supportingValue - currentValue
    case .multiply:
      resultValue = supportingValue * currentValue
    case .divide:
      resultValue = supportingValue / currentValue
    }
    
    return String(resultValue)
  }
  
  private func handleTappedPointSign() {
    if !expressionViewModel.currentValue.value.contains(CalculationItemType.point.stringValue) {
      expressionViewModel.currentValue.value += expressionViewModel.currentValue.value.isEmpty ? "0." : "."
    }
  }
  
  private func handleTappedEqualSign(_ resultValue: String) {
    guard let resultValue = Double(resultValue) else { return }
    
    if resultValue.truncatingRemainder(dividingBy: 1) == 0 {
      delegate?.calculationViewModelDidRequestToUpdateAfterEqual(self, with: String(Int(resultValue)))
    } else {
      let resultRoundedNumber = round(resultValue * 1000) / 1000
      delegate?.calculationViewModelDidRequestToUpdateAfterEqual(self, with: String(resultRoundedNumber))
    }
  }
  
  private func resetAllValues() {
    expressionViewModel.currentValue.value = ""
    expressionViewModel.supprotingValue.value = ""
    expressionViewModel.previousSign.value = ""
  }
  
  private func backToPreviousValue() {
    if !expressionViewModel.currentValue.value.isEmpty {
      expressionViewModel.currentValue.value = String(expressionViewModel.currentValue.value.dropLast())
    }
  }
  
  private func toggleSignOfCurrentValue() {
    if !expressionViewModel.currentValue.value.isEmpty {
      expressionViewModel.currentValue.value = String(-(Int(expressionViewModel.currentValue.value) ?? 0))
    }
  }
  
  private func handleTappedPercent() {
    if !expressionViewModel.currentValue.value.isEmpty && !expressionViewModel.supprotingValue.value.isEmpty {
      if expressionViewModel.previousSign.value == CalculationItemType.multiply.stringValue {
        let percentValue = (Double(expressionViewModel.currentValue.value) ?? 0) / 100
        let resultValue = (Double(expressionViewModel.supprotingValue.value) ?? 0) * percentValue
        resetAllValues()
        expressionViewModel.currentValue.value = String(round(resultValue * 1000) / 1000)
      }
    }
  }
}

// MARK: - CalculationCollectionCellViewModelDelegate
extension CalculationViewModel: CalculationCellViewModelDelegate {
  func cellViewModelDidRequetsToUpdateValue(_ viewModel: CalculationCellViewModel, with itemType: CalculationItemType) {
    switch itemType {
    case .resetValues:
      resetAllValues()
    case .plusMinus:
      toggleSignOfCurrentValue()
    case .percent:
      handleTappedPercent()
    case .previousValue:
      backToPreviousValue()
    default:
      handleTappedCalculatorButton(with: itemType)
    }
  }
}
