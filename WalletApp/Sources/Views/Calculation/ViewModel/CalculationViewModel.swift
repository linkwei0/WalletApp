//
//  CalculationViewViewModel.swift
//  WalletApp
//

import Foundation

protocol CalculationViewModelDelegate: AnyObject {
  func calculationViewModelDidRequestToUpdateValue(_ viewModel: CalculationViewModel,
                                                   with value: String)
  func calculationViewModelDidRequestToUpdateAllValues(_ viewModel: CalculationViewModel,
                                                       with value: String, sign: String)
  func calculationViewModelDidRequestToUpdateAfterEqual(_ viewModel: CalculationViewModel,
                                                        with value: String)
}

protocol CalculationViewModelCategoryDelegate: AnyObject {
  func calculationViewModelDidRequestToShowCategoryView(_ viewModel: CalculationViewModel,
                                                        wallet: WalletModel, totalValue: String)
}

final class CalculationViewModel: SimpleViewStateProcessable {
  // MARK: - Properties
  private enum Sign: String {
    case minus = "-", plus = "+", multiply = "x", divide = "/"
  }
  
  weak var delegate: CalculationViewModelDelegate?
  weak var categoryDelegate: CalculationViewModelCategoryDelegate?
  
  let expressionViewModel: ExpressionViewModel
    
  private(set) var collectionType: CollectionType
  private(set) var calculationButtons: [[CalculationItemType]] =
  [
    [.clearAC, .plusMinus, .percent, .divide],
    [.seven, .eight, .nine, .multiply],
    [.four, .five, .six, .minus],
    [.one, .two, .three, .plus],
    [.back, .zero, .comma, .equal]
  ]
  
  private let setOfNumbers: Set<String> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
  private let setOfSigns: Set<String> = ["+", "-", "x", "/"]
  
  private let wallet: WalletModel
  private let interactor: CalculationInteractorProtocol

  // MARK: - Init
  init(interactor: CalculationInteractorProtocol, wallet: WalletModel, collectionType: CollectionType) {
    self.interactor = interactor
    self.wallet = wallet
    self.collectionType = collectionType
    self.expressionViewModel = ExpressionViewModel(interactor: interactor, wallet: wallet)
    delegate = expressionViewModel
  }
    
  // MARK: - Public methods
  func configureItemType(_ indexPath: IndexPath) -> CalculationCellViewModel {
    let itemType = calculationButtons[indexPath.section][indexPath.row]
    let cellViewModel = CalculationCellViewModel(collectionType: collectionType,
                                                 itemType: itemType)
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
    categoryDelegate?.calculationViewModelDidRequestToShowCategoryView(self, wallet: wallet, totalValue: expressionViewModel.currentValue.value)
  }
  
  func updateOperations() {
    expressionViewModel.currentValue.value = ""
    expressionViewModel.supprotingValue.value = ""
    expressionViewModel.previousSign.value = ""
    expressionViewModel.updateOperations()
  }

  func updateCurrentValue(with itemType: CalculationItemType) {
    let itemStringValue = itemType.stringValue
    let currentValue = expressionViewModel.currentValue.value
    let supportingValue = expressionViewModel.supprotingValue.value
    let previousSign = expressionViewModel.previousSign.value
        
    if setOfNumbers.contains(itemStringValue) {
      delegate?.calculationViewModelDidRequestToUpdateValue(self, with: currentValue + itemStringValue)
    }
    
    if setOfSigns.contains(itemStringValue) && !currentValue.isEmpty {
      var updateValue = currentValue
      if let sign = Sign(rawValue: previousSign) {
        updateValue = handleChainOfSigns(supportingValue, currentValue, sign)
      }
      delegate?.calculationViewModelDidRequestToUpdateAllValues(self, with: updateValue, sign: itemStringValue)
    }
    
    if itemStringValue == ",", !currentValue.contains(".") {
      convertValueToDecimal(currentValue)
    }
    
    if itemStringValue == "=", let sign = Sign(rawValue: previousSign) {
      calculateResultValue(supportingValue, currentValue, sign)
    }
  }
  
  // MARK: - Private methods
  private func handleChainOfSigns(_ prevValue: String, _ currentValue: String,
                                  _ currentSign: Sign) -> String {
    var updateValue: String
    var resultValue: Double
    let value1 = Double(prevValue) ?? 0
    let value2 = Double(currentValue) ?? 0

    switch currentSign {
    case .plus:
      resultValue = value1 + value2
    case .minus:
      resultValue = value1 - value2
    case .multiply:
      resultValue = value1 * value2
    case .divide:
      resultValue = value1 / value2
    }
    
    if resultValue.truncatingRemainder(dividingBy: 1) == 0 {
      updateValue = String(Int(resultValue))
    } else {
      let roundedNumber = round(resultValue * 1000) / 1000
      updateValue = String(roundedNumber)
    }
    return updateValue
  }
  
  private func convertValueToDecimal(_ prevValue: String) {
    var updateValue = prevValue
    if updateValue.isEmpty {
      updateValue = "0."
    } else {
      updateValue += "."
    }
    delegate?.calculationViewModelDidRequestToUpdateValue(self, with: updateValue)
  }
  
  private func calculateResultValue(_ resultValue: String, _ prevValue: String, _ currentSign: Sign) {
    var updateValue: Double
    let value1 = Double(resultValue) ?? 0
    let value2 = Double(prevValue) ?? 0

    switch currentSign {
    case .plus:
      updateValue = value1 + value2
    case .minus:
      updateValue = value1 - value2
    case .multiply:
      updateValue = value1 * value2
    case .divide:
      updateValue = value1 / value2
    }
        
    if updateValue.truncatingRemainder(dividingBy: 1) == 0 {
      delegate?.calculationViewModelDidRequestToUpdateAfterEqual(self, with: String(Int(updateValue)))
    } else {
      let roundedNumber = round(updateValue * 1000) / 1000
      delegate?.calculationViewModelDidRequestToUpdateAfterEqual(self, with: String(roundedNumber))
    }
  }
  
  private func clearAllValues() {
    expressionViewModel.currentValue.value = ""
    expressionViewModel.supprotingValue.value = ""
    expressionViewModel.previousSign.value = ""
  }
  
  private func backToPreviousValue() {
    if !expressionViewModel.currentValue.value.isEmpty {
      expressionViewModel.currentValue.value = String(expressionViewModel.currentValue.value.dropLast())
    }
  }
}

// MARK: - CalculationCollectionCellViewModelDelegate
extension CalculationViewModel: CalculationCellViewModelDelegate {
  func cellViewModelDidRequetsToUpdateValue(_ viewModel: CalculationCellViewModel,
                                            with itemType: CalculationItemType) {
    switch itemType {
    case .clearAC:
      clearAllValues()
    case .plusMinus:
      print("plus/minus")
    case .percent:
      print("percent")
    case .back:
      backToPreviousValue()
    default:
      updateCurrentValue(with: itemType)
    }
  }
}
