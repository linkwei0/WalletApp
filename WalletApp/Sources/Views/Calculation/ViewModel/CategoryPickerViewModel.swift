//
//  CategoryPickerViewModel.swift
//  WalletApp
//

import Foundation

class CategoryPickerViewModel {
  // MARK: - Properties
  private let categories: [[CategoryType]] =
  [
    [.food, .house, .car],
    [.phone, .transport]
  ]
  
  // MARK: - Public methods
  func numberOfSections() -> Int {
    return categories.count
  }
  
  func numberOfItemsInSection(section: Int) -> Int {
    return categories[section].count
  }
  
  func configureItemType(_ indexPath: IndexPath) -> CategoryCellViewModel {
    let categoryType = categories[indexPath.section][indexPath.row]
    let cellViewModel = CategoryCellViewModel(categoryType: categoryType)
    return cellViewModel
  }
}
