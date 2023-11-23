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
  
  func isCurrentMonth() -> Bool {
    guard let result = Calendar.current.dateInterval(of: .month, for: Date()) else { return false }
    return result.contains(self)
  }
  
  func dateInterval() -> DateInterval {
    guard let result = Calendar.current.dateInterval(of: .day, for: self) else { return DateInterval() }
    return result
  }
  
  func interval(to endDate: Date) -> DateComponents {
    let result = Calendar.current.dateComponents([.day], from: self, to: endDate)
    return result
  }
  
  func numberOfDays(_ date: Date) -> Int {
    let result = Calendar.current.numberOfDaysBetween(self, date)
    return result
  }
}

private extension Calendar {
  func numberOfDaysBetween(_ from: Date, _ to: Date) -> Int {
    let fromDate = startOfDay(for: from)
    let toDate = startOfDay(for: to)
    let numberOfDays = dateComponents([.day], from: fromDate, to: toDate).day
    return numberOfDays ?? 0
  }
}
