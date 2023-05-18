//
//  CalculationViewViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 26.01.2023.
//

import Foundation

enum Sign: String {
  case minus = "-", plus = "+", multiply = "x", divide = "/"
}

final class CalculationViewViewModel {
  // MARK: - Properties
  
  var onUpdateCurrentValue: ((String) -> Void)?
  var onUpdateAllValues: ((String, String) -> Void)?
  var onUpdateUIAfterEqual: ((String) -> Void)?
  
  let customViewViewModel = CustomCalculationViewViewModel()
  
  private(set) var collectionType: CollectionType
  
  private(set) var calculationButtons: [[CalculationItemType]] =
  [
    [.seven, .eight, .nine, .divide],
    [.four, .five, .six, .multiply],
    [.one, .two, .three, .minus],
    [.zero, .comma, .equal, .plus]
  ]
  
  private let setOfNumbers: Set<String> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
  private let setOfSigns: Set<String> = ["+", "-", "x", "/"]

  // MARK: - Init
  
  init(collectionType: CollectionType) {
    self.collectionType = collectionType
  }
    
  // MARK: - Public methods
  
  func configureItemType(_ indexPath: IndexPath) -> CalculationCollectionCellViewModel {
    let itemType = calculationButtons[indexPath.section][indexPath.row]
    let cellViewModel = CalculationCollectionCellViewModel(collectionType: collectionType,
                                                           itemType: itemType)
    cellViewModel.delegate = self
    return cellViewModel
  }
  
  func didUpdateCurrentValue(with itemType: CalculationItemType) {
    let itemStringValue = itemType.stringValue
    let currentValue = customViewViewModel.currentValue
    let supportingValue = customViewViewModel.suppotingValue
    let previousSign = customViewViewModel.previosSign
        
    if setOfNumbers.contains(itemStringValue) {
      customViewViewModel.updateCurrentValue(currentValue + itemStringValue)
    }
    
    if setOfSigns.contains(itemStringValue) && !currentValue.isEmpty {
      var updateValue = currentValue
      if let sign = Sign(rawValue: previousSign) {
        updateValue = handleChainOfSigns(supportingValue, currentValue, sign)
      }
      customViewViewModel.updateAllValue(updateValue, itemStringValue)
    }
    
    if itemStringValue == ",", !currentValue.contains(".") {
      handleCommaSign(currentValue)
    }
    
    if itemStringValue == "=", let sign = Sign(rawValue: previousSign) {
      handleEqualButton(supportingValue, currentValue, sign)
    }
  }
  
  // MARK: - Private methods
  
  private func handleChainOfSigns(_ prevValue: String, _ currentValue: String,
                                  _ currentSign: Sign) -> String {
    var updateValue: String
    var resultValue: Double
    let value1 = Double(prevValue) ?? 0
    let value2 = Double(currentValue) ?? 0
    print(prevValue, currentValue, currentSign)
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
  
  private func handleCommaSign(_ prevValue: String) {
    var updateValue: String = prevValue
    if updateValue.isEmpty {
      updateValue = "0."
    } else {
      updateValue += "."
    }
    customViewViewModel.updateCurrentValue(updateValue)
  }
  
  private func handleEqualButton(_ resultValue: String, _ prevValue: String, _ currentSign: Sign) {
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
      customViewViewModel.updateAfterEqual(String(Int(updateValue)))
    } else {
      let roundedNumber = round(updateValue * 1000) / 1000
      customViewViewModel.updateAfterEqual(String(roundedNumber))
    }
  }
}

// MARK: - CalculationCollectionCellViewModelDelegate

extension CalculationViewViewModel: CalculationCollectionCellViewModelDelegate {
  func collectionCellViewModelDidRequetsToUpdateValue(_ viewModel: CalculationCollectionCellViewModel,
                                                      itemType: CalculationItemType) {
    didUpdateCurrentValue(with: itemType)
  }
}
