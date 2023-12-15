//
//  String+Convert.swift
//  WalletApp
//
//  Created by Артём Бацанов on 06.12.2023.
//

import Foundation

extension String {
  func withoutSpaces() -> String {
    guard !self.isEmpty else { return "" }
    return self.components(separatedBy: " ").joined()
  }
  
  func makeSpaces() -> String {
    guard !self.isEmpty else { return "" }
    let arr = Array(self)
    var result: [String] = []
    var counter = 0
    
    for index in (0..<arr.count).reversed() {
      if counter == 3 {
        result.append(" ")
        result.append(String(arr[index]))
        counter = 1
      } else {
        result.append(String(arr[index]))
        counter += 1
      }
    }
    
    return result.reversed().joined()
  }
}
