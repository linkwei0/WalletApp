//
//  Int+StringSeparator.swift
//  WalletApp
//
//  Created by Артём Бацанов on 20.11.2023.
//

import Foundation

extension Int {
  func makeDigitSeparator() -> String {
    let digits = String(self).compactMap { $0.wholeNumberValue }
    var arr: [String] = []
    var counter = 0
    
    for index in stride(from: digits.count - 1, to: -1, by: -1) {
      if counter == 3 {
        arr.append(" ")
        arr.append(String(digits[index]))
        counter = 1
      } else {
        arr.append(String(digits[index]))
        counter += 1
      }
    }
    
    return arr.reversed().joined()
  }
}
