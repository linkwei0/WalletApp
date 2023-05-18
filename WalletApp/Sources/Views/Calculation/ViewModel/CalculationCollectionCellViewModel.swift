//
//  CalculationCollectionCellViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 13.05.2023.
//

import UIKit

protocol CalculationCollectionCellViewModelDelegate: AnyObject {
  func collectionCellViewModelDidRequetsToUpdateValue(_ viewModel: CalculationCollectionCellViewModel,
                                                      itemType: CalculationItemType)
}

final class CalculationCollectionCellViewModel {
  weak var delegate: CalculationCollectionCellViewModelDelegate?
  
  // MARK: - Properties
  
  private let collectionType: CollectionType
  private let itemType: CalculationItemType
  
  var backgroundColor: UIColor {
    .accentDark
  }
  
  var tintColor: UIColor {
    collectionType == .income ? UIColor.baseWhite : UIColor.baseBlack
  }
  
  var borderColor: UIColor {
    collectionType == .income ? UIColor.baseWhite : UIColor.baseBlack
  }
  
  var iconImage: UIImage? {
    itemType.iconImage
  }
  
  // MARK: - Init
  
  init(collectionType: CollectionType, itemType: CalculationItemType) {
    self.collectionType = collectionType
    self.itemType = itemType
  }
  
  // MARK: - Public methods
  
  func didTapCell() {
    delegate?.collectionCellViewModelDidRequetsToUpdateValue(self, itemType: itemType)
  }
}
