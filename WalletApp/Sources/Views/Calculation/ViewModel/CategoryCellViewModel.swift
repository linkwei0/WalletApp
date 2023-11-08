//
//  CategoryCellViewModel.swift
//  WalletApp
//

import UIKit

protocol CategoryTypeProtocol {
  var image: UIImage? { get }
  var title: String { get }
  var imageColor: UIColor { get }
}

enum IncomeCategoryType: String, CaseIterable, CategoryTypeProtocol {
  case present = "Подарок"
  case salary = "Зарплата"
  case partjob = "Подработка"
  case dividends = "Дивиденды"
  
  var image: UIImage? {
    switch self {
    case .present:
      return UIImage(systemName: "gift.fill")
    case .salary:
      return UIImage(systemName: "banknote.fill")
    case .partjob:
      return UIImage(systemName: "bag.fill")
    case .dividends:
      return UIImage(systemName: "creditcard.fill")
    }
  }
  
  var title: String {
    switch self {
    case .present:
      return "Подарок"
    case .salary:
      return "Зарплата"
    case .partjob:
      return "Подработка"
    case .dividends:
      return "Дивиденды"
    }
  }
  
  var imageColor: UIColor {
    switch self {
    case .present, .salary, .partjob, .dividends:
      return .incomeBtnColor
    }
  }
}

enum ExpenseCategoryType: String, CaseIterable, CategoryTypeProtocol {
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
  
  var imageColor: UIColor {
    switch self {
    case .food, .house, .phone, .car, .transport:
      return .expenseBtnColor
    }
  }
}

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
  
  private let categoryType: CategoryTypeProtocol
  
  init(categoryType: CategoryTypeProtocol) {
    self.categoryType = categoryType
  }
}
