//
//  CategoryCellViewModel.swift
//  WalletApp
//

import UIKit

enum CategoryType {
  case food, house, phone, car, transport
  
  var image: UIImage? {
    switch self {
    case .food:
      return UIImage(systemName: "takeoutbag.and.cup.and.straw")
    case .house:
      return UIImage(systemName: "house")
    case .phone:
      return UIImage(systemName: "phone")
    case .car:
      return UIImage(systemName: "car")
    case .transport:
      return UIImage(systemName: "bus.fill")
    }
  }
}

class CategoryCellViewModel {
  var iconImage: UIImage? {
    return categoryType.image
  }
  
  private let categoryType: CategoryType
  
  init(categoryType: CategoryType) {
    self.categoryType = categoryType
  }
}
