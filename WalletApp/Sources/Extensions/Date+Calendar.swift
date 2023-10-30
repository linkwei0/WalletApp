//
//  Date+Calendar.swift
//  WalletApp
//
//  Created by Артём Бацанов on 30.10.2023.
//

import Foundation

extension Date {
  func isToday() -> Bool {
    return Calendar.current.isDateInToday(self)
  }
  
  func isYesterday() -> Bool {
    return Calendar.current.isDateInYesterday(self)
  }
  
  func isLastWeek() -> Bool {
    return Calendar.current.isDateInWeekend(self)
  }
}
