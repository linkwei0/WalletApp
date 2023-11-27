//
//  OperationDateType.swift
//  WalletApp
//
//  Created by Артём Бацанов on 29.10.2023.
//

import Foundation

enum OperationDateType: CaseIterable {
  case today
  case yesterday
  
  var title: String {
    switch self {
    case .today:
      return "Сегодня"
    case .yesterday:
      return "Вчера"
    }
  }
}
