//
//  CalculationCollectionCellViewModel.swift
//  WalletApp
//

import UIKit

protocol CalculationCellViewModelDelegate: AnyObject {
  func cellViewModelDidRequetsToUpdateValue(_ viewModel: CalculationCellViewModel,
                                            with itemType: CalculationItemType)
}

final class CalculationCellViewModel {
  weak var delegate: CalculationCellViewModelDelegate?
  
  // MARK: - Properties
    
  private let collectionType: CalculationType
  private let itemType: CalculationItemType
  
  var backgroundColor: UIColor {
    .accentDark
  }
  
  var tintColor: UIColor {
      return itemType.tintColor
  }
  
  var borderColor: UIColor {
    collectionType == .income ? UIColor.baseWhite : UIColor.baseBlack
  }
  
  var iconImage: UIImage? {
    itemType.iconImage
  }
  
  // MARK: - Init
  
  init(collectionType: CalculationType, itemType: CalculationItemType) {
    self.collectionType = collectionType
    self.itemType = itemType
  }
  
  // MARK: - Public methods
  
  func didTapCell() {
    delegate?.cellViewModelDidRequetsToUpdateValue(self, with: itemType)
  }
}
