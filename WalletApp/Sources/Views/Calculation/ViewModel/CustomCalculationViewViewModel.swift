//
//  CustomCalculationViewViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 15.05.2023.
//

import Foundation

final class CustomCalculationViewViewModel {
  // MARK: - Properties
  
  var onUpdateCurrentValue: ((String) -> Void)?
  var onUpdateAllValues: ((String, String) -> Void)?
  var onUpdateUIAfterEqual: ((String) -> Void)?
  
  private(set) var currentValue: String = ""
  private(set) var suppotingValue: String = ""
  private(set) var previosSign: String = ""
  
  // MARK: - Public methods
  
  func updateCurrentValue(_ updateValue: String) {
    currentValue = updateValue
    onUpdateCurrentValue?(updateValue)
  }
  
  func updateAllValue(_ updateValue: String, _ currentSign: String) {
    currentValue = ""
    suppotingValue = updateValue
    previosSign = currentSign
    onUpdateAllValues?(updateValue, currentSign)
  }
  
  func updateAfterEqual(_ resultValue: String) {
    currentValue = resultValue
    suppotingValue = ""
    previosSign = ""
    onUpdateUIAfterEqual?(resultValue)
  }
  
  func onDidTapClearButton(value: String) {
    if !value.isEmpty {
      let endIndex = value.count - 1
      let previosValue = value[0..<endIndex]
      currentValue = previosValue
      onUpdateCurrentValue?(previosValue)
    }
  }
  
  func onDidTapCheckButton(_ value: String) {
    // TODO: - Save in db and drop in main value
    currentValue = value
    suppotingValue = ""
    onUpdateAllValues?("", "")
  }
  
  func onDidTapAllClearButton() {
    currentValue = ""
    suppotingValue = ""
    onUpdateAllValues?("", "")
  }
}
