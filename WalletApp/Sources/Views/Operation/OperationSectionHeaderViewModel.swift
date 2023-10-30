//
//  OperationSectionHeaderViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 29.10.2023.
//

import Foundation

class OperationSectionHeaderViewModel: TableHeaderViewModel {
  var tableReuseIdentifier: String {
    OperationSectionHeaderView.reuseIdentifiable
  }
  
  let title: String
  let totalValue: String
  let topInset: CGFloat
  
  init(title: String, totalValue: String, isFirstSection: Bool) {
    self.title = title
    self.totalValue = totalValue
    self.topInset = isFirstSection ? 16 : 32
  }
}
