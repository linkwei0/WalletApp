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
}
