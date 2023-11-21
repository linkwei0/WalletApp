//
//  CategoryCellViewModel.swift
//  WalletApp
//

import UIKit


class CategoryCellViewModel {
  var iconImage: UIImage? {
    return categoryType.image
  }
  
  var title: String {
    return categoryType.title
  }
  
  var imageColor: UIColor {
    return categoryType.imageColor
  }
  
  private let categoryType: CategoryTypesProtocol
  
  init(categoryType: CategoryTypesProtocol) {
    self.categoryType = categoryType
  }
}
