//
//  CalculationViewViewModel.swift
//  WalletApp
//

import Foundation

protocol CalculationViewModelDelegate: AnyObject {
  func viewModelDidRequestToUpdateAllValues(_ viewModel: CalculationViewModel, currentValue: String,
                                            prevValue: String, sign: String)
  func viewModelDidRequestToShowResult(_ viewModel: CalculationViewModel, _ result: String)
  func viewModelDidRequestToAddNewNumber(_ viewModel: CalculationViewModel, with value: String)
  func viewModelDidRequestToUpdateFractionalStatus(_ viewModel: CalculationViewModel, isFractional: Bool)
  func viewModelDidRequestToDropLastNumber(_ viewModel: CalculationViewModel)
  func viewModelDidRequestToToggleSign(_ viewModel: CalculationViewModel, _ currentValue: String)
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
    guard !expressionViewModel.currentValue.isEmpty else { return }
    let amount = expressionViewModel.currentValue
    let operationType: OperationType = operationType == .income ? .income : .expense
    let operation = OperationModel(id: UUID().hashValue, walletId: wallet.id, name: "",
                                   amount: Decimal(string: amount) ?? 0, category: "",
                                   date: Date(), type: operationType)
    calculationCategoryDelegate?.calculationViewModelDidRequestToShowCategoryView(self, wallet: wallet, operation: operation)
  }
  
  func updateOperations() {
    resetAllValues()
    expressionViewModel.updateOperations()
  }
  
  // MARK: - Private methods
  private func handleTappedCalculatorButton(with itemType: CalculationItemType) {
    if expressionViewModel.currentValue.count <= maxNumberLength {
      if itemType.isNumber {
        delegate?.viewModelDidRequestToAddNewNumber(self, with: itemType.stringValue)
      }
      
      if itemType.isSign && !expressionViewModel.currentValue.isEmpty {
        let resultValue = handleTappedArithmeticSign()
        delegate?.viewModelDidRequestToUpdateAllValues(self, currentValue: "", prevValue: resultValue,
                                                       sign: itemType.stringValue)
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
    let supportingValue = Double(expressionViewModel.previousValue) ?? 0
    let currentValue = Double(expressionViewModel.currentValue) ?? 0
    let sign = Sign(rawValue: expressionViewModel.sign) ?? .plus
    
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
    if !expressionViewModel.currentValue.contains(CalculationItemType.point.stringValue) {
      delegate?.viewModelDidRequestToUpdateFractionalStatus(self, isFractional: true)
      let value = expressionViewModel.currentValue.isEmpty ? "0." : "."
      delegate?.viewModelDidRequestToAddNewNumber(self, with: value)
    }
  }
  
  private func handleTappedEqualSign(_ resultValue: String) {
    guard let resultValue = Double(resultValue) else { return }
    
    if resultValue.truncatingRemainder(dividingBy: 1) == 0 {
      delegate?.viewModelDidRequestToShowResult(self, String(Int(resultValue)))
    } else {
      let resultRoundedNumber = round(resultValue * 1000) / 1000
      delegate?.viewModelDidRequestToShowResult(self, String(resultRoundedNumber))
    }
  }
  
  private func resetAllValues() {
    delegate?.viewModelDidRequestToUpdateAllValues(self, currentValue: "", prevValue: "", sign: "")
  }
  
  private func backToPreviousValue() {
    if !expressionViewModel.currentValue.isEmpty {
      delegate?.viewModelDidRequestToDropLastNumber(self)
    }
  }
  
  private func toggleSignOfCurrentValue() {
    if !expressionViewModel.currentValue.isEmpty {
      delegate?.viewModelDidRequestToToggleSign(self, String(-(Int(expressionViewModel.currentValue) ?? 0)))
    }
  }
  
  private func handleTappedPercent() {
    if !expressionViewModel.currentValue.isEmpty && !expressionViewModel.previousValue.isEmpty {
      if expressionViewModel.sign == CalculationItemType.multiply.stringValue {
        let percentValue = (Double(expressionViewModel.currentValue) ?? 0) / 100
        let resultValue = (Double(expressionViewModel.previousValue) ?? 0) * percentValue
        resetAllValues()
        delegate?.viewModelDidRequestToShowResult(self, String(round(resultValue * 1000) / 1000))
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
