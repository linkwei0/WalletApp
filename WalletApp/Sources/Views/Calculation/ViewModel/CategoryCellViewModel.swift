//
//  CategoryCellViewModel.swift
//  WalletApp
//

import UIKit

enum CategoryType: String {
  case food = "Продукты"
  case house = "Дом"
  case phone = "Телефон"
  case car = "Машина"
  case transport = "Транспорт"
  
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
  
  var title: String {
    switch self {
    case .food:
      return "Продукты"
    case .house:
      return "Дом"
    case .phone:
      return "Телефон"
    case .car:
      return "Машина"
    case .transport:
      return "Транспорт"
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
