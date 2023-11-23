//
//  Decimal+Compare.swift
//  WalletApp
//
//  Created by Артём Бацанов on 23.11.2023.
//

import Foundation

extension Decimal {
  func isLess(than number: Decimal) -> Bool {
    return self < number
  }
}
