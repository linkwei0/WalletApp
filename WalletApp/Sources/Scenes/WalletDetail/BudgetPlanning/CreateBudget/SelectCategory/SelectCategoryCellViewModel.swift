//
//  SelectCategoryCellViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 21.11.2023.
//

import UIKit

protocol SelectCategoryCellViewModelProtocol {
  var name: String { get }
  var icon: UIImage? { get }
  var arrow: UIImage? { get }
}

class SelectCategoryCellViewModel: SelectCategoryCellViewModelProtocol {
  var icon: UIImage? {
    return expenseType.image
  }
  
  var arrow: UIImage? {
    return UIImage(systemName: "arrowshape.forward.fill")
  }
  
  var name: String {
    return expenseType.title
  }
  
  private let expenseType: ExpenseCategoryTypes
  
  init(_ expenseType: ExpenseCategoryTypes) {
    self.expenseType = expenseType
  }
}
