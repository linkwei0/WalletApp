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
      return R.string.walletDetail.selectPeriodTypesWeeklyTitle()
    case .monthly:
      return R.string.walletDetail.selectPeriodTypesMonthlyTitle()
    }
  }
  
  var arrow: UIImage? {
    switch self {
    case .weekly:
      return UIImage(systemName: Constants.arrowString)
    case .monthly:
      return UIImage(systemName: Constants.arrowString)
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

private extension Constants {
  static let arrowString = "arrowshape.forward.fill"
}
