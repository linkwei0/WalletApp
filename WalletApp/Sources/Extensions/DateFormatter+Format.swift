//
//  DateFormatter+Format.swift
//  WalletApp
//
//  Created by Артём Бацанов on 22.11.2023.
//

import Foundation

private extension Constants {
  static let dayMonthYearDisplay = "dd.MM.yy"
}

extension DateFormatter {
  static let dayMonthYearDisplay = dateFormatter(format: Constants.dayMonthYearDisplay)
  
  private static func dateFormatter(format: String, timeZone: TimeZone? = .current) -> DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    dateFormatter.timeZone = timeZone
    dateFormatter.locale = .current
    return dateFormatter
  }
}
