//
//  OperationSectionHeaderViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 29.10.2023.
//

import Foundation

class OperationHeaderViewModel: TableHeaderViewModel {
  var tableReuseIdentifier: String {
    OperationHeaderView.reuseIdentifiable
  }
  
  let title: String
  let totalValue: String
  let topInset: CGFloat
  
  init(title: String, totalValue: String = "", isFirstSection: Bool = false) {
    self.title = title
    self.totalValue = totalValue
    self.topInset = isFirstSection ? 20 : 16
  }
}
