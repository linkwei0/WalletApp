//
//  OperationSectionHeaderViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 29.10.2023.
//

import UIKit

enum OperationHeaderTypes {
  case common, list
}

class OperationHeaderViewModel: TableHeaderViewModel {
  var tableReuseIdentifier: String {
    OperationHeaderView.reuseIdentifiable
  }
  
  var titleFont: UIFont? {
    return type == .common ? .bodyBold : .header2
  }
  
  var topLineColor: UIColor {
    return type == .common ? .shade3 : .clear
  }
  
  var bottomLineColor: UIColor {
    return type == .common ? .shade3 : .clear
  }
  
  let title: String
  let totalValue: String
  let topInset: CGFloat
  
  private let type: OperationHeaderTypes
  
  init(title: String, type: OperationHeaderTypes, totalValue: String = "", isFirstSection: Bool = false) {
    self.title = title
    self.type = type
    self.totalValue = totalValue
    self.topInset = isFirstSection ? 20 : 12
  }
}
