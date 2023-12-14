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
//  
//  func makeSpaces() -> String {
//    let str = self.compactMap { $0.wholeNumberValue }
//    var arr: [String] = []
//    var counter = 0
//    
//    for index in stride(from: str.count - 1, to: -1, by: -1) {
//      if counter == 3 {
//        arr.append(" ")
//        arr.append(String(str[index]))
//        counter = 1
//      } else {
//        arr.append(String(str[index]))
//        counter += 1
//      }
//    }
//    
//    return arr.reversed().joined()
//  }
}
