//
//  SelectPeriodCellViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 20.11.2023.
//

import UIKit

enum SelectPeriodTypes: CaseIterable {
  case weekly, monthly
  
  var title: String {
    switch self {
    case .weekly:
      return "На неделю"
    case .monthly:
      return "На месяц"
    }
  }
  
  var arrow: UIImage? {
    switch self {
    case .weekly:
      return UIImage(systemName: "arrowshape.forward.fill")
    case .monthly:
      return UIImage(systemName: "arrowshape.forward.fill")
    }
  }
}

protocol SelectPeriodCellViewModelProtocol {
  var title: String { get }
  var arrow: UIImage? { get }
}

class SelectPeriodCellViewModel: SelectPeriodCellViewModelProtocol {
  var title: String {
    return periodType.title
  }
  
  var arrow: UIImage? {
    return periodType.arrow
  }
  
  private let periodType: SelectPeriodTypes
  
  init(_ periodType: SelectPeriodTypes) {
    self.periodType = periodType
  }
}
