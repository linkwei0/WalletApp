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

class CalculationViewViewModel {
  // MARK: - Properties
  
  var onUpdateCurrentValue: ((String) -> Void)?
  var onUpdateAllValues: ((String, String) -> Void)?
  var onUpdateUIAfterEqual: ((String) -> Void)?
    
  var test = 0
  
  private let setOfNumbers: Set<String> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
  private let setOfSigns: Set<String> = ["+", "-", "x", "/"]
  
  private(set) var calculationButtons: [[CalculationItemType]] =
  [
    [.seven, .eight, .nine, .divide],
    [.four, .five, .six, .multiply],
    [.one, .two, .three, .minus],
    [.zero, .comma, .equal, .plus]
  ]
    
  // MARK: - Public methods
  
  func configureItemType(_ indexPath: IndexPath) -> CalculationItemType {
    return calculationButtons[indexPath.section][indexPath.row]
  }
  
  func didUpdateCurrentValue(with indexPath: IndexPath, prevValue: String,
                             resultValue: String, currentSign: String) {
    let buttonStringValue = calculationButtons[indexPath.section][indexPath.row].stringValue
    
    if setOfNumbers.contains(buttonStringValue) {
      onUpdateCurrentValue?(prevValue + buttonStringValue)
    }
    
    if setOfSigns.contains(buttonStringValue) && !prevValue.isEmpty {
      var updateValue = prevValue
      if let sign = Sign(rawValue: currentSign) {
        updateValue = handleChainOfSigns(prevValue, resultValue, sign)
      }
      onUpdateAllValues?(updateValue, buttonStringValue)
    }
    
    if buttonStringValue == ",", !prevValue.contains(".") {
      handleCommaSign(prevValue)
    }
    
    if buttonStringValue == "=", let sign = Sign(rawValue: currentSign) {
      handleEqualButton(resultValue, prevValue, sign)
    }
  }
  
  func onDidTapClearButton(currentValue: String) {
    if !currentValue.isEmpty {
      let endIndex = currentValue.count - 1
      let previosValue = currentValue[0..<endIndex]
      onUpdateCurrentValue?(previosValue)
    }
  }
  
  func onDidTapCheckButton(_ value: String) {
    // TODO: - Save in db and drop in main value
    onUpdateAllValues?("", "")
  }
  
  func onDidTapAllClearButton() {
    onUpdateAllValues?("", "")
  }
  
  // MARK: - Private methods
  
  private func handleChainOfSigns(_ prevValue: String, _ currentValue: String,
                                  _ currentSign: Sign) -> String {
    var updateValue: String
    var resultValue: Double
    let value1 = Double(currentValue) ?? 0
    let value2 = Double(prevValue) ?? 0
    
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
    onUpdateCurrentValue?(updateValue)
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
      onUpdateUIAfterEqual?(String(Int(updateValue)))
    } else {
      let roundedNumber = round(updateValue * 1000) / 1000
      onUpdateUIAfterEqual?(String(roundedNumber))
    }
  }
}
