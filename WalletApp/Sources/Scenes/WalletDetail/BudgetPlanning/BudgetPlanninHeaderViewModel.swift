//
//  BudgetPlanninHeaderViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 23.11.2023.
//

import Foundation

class BudgetPlanninHeaderViewModel {
  var text: String {
    return title
  }
  
  private let title: String
  
  init(title: String) {
    self.title = title
  }
}

// MARK: - TableHeaderViewModel
extension BudgetPlanninHeaderViewModel: TableHeaderViewModel {
  var tableReuseIdentifier: String {
    return BudgetPlanningHeaderView.reuseIdentifiable
  }
}
