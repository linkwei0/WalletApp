//
//  String+Limit.swift
//  WalletApp
//

import Foundation

extension String {
  func maxLength(to symbols: Int) -> String {
    guard self.count > symbols else {
      return self
    }
    return self.prefix(symbols) + "..."
  }
}
