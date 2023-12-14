//
//  TimeInterval.swift
//  WalletApp
//
//  Created by Артём Бацанов on 14.12.2023.
//

import Foundation

extension TimeInterval {
  func randomInterval(variance: Double) -> TimeInterval {
    return self + variance * Double((Double(arc4random_uniform(1000)) - 500.0) / 500.0)
  }
}
