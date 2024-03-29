//
//  ElementCollectionCellViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 16.11.2023.
//

import UIKit

enum ModalCalculationViewTypes {
  case zero, one, two, three, four, five, six,
       seven, eight, nine, point, previousValue
  
  var stringValue: String {
    switch self {
    case .zero:
      return "0"
    case .one:
      return "1"
    case .two:
      return "2"
    case .three:
      return "3"
    case .four:
      return "4"
    case .five:
      return "5"
    case .six:
      return "6"
    case .seven:
      return "7"
    case .eight:
      return "8"
    case .nine:
      return "9"
    case .point:
      return "."
    case .previousValue:
      return "prev"
    }
  }
  
  var iconImage: UIImage? {
    switch self {
    case .zero:
      return R.image.zeroButton()
    case .one:
      return R.image.oneButton()
    case .two:
      return R.image.twoButton()
    case .three:
      return R.image.threeButton()
    case .four:
      return R.image.fourButton()
    case .five:
      return R.image.fiveButton()
    case .six:
      return R.image.sixButton()
    case .seven:
      return R.image.sevenButton()
    case .eight:
      return R.image.eightButton()
    case .nine:
      return R.image.nineButton()
    case .point:
      return R.image.commaButton()
    case .previousValue:
      return UIImage(systemName: Constants.previousArrowImage)
    }
  }
}

protocol ModalCalculationCellViewModelDelegate: AnyObject {
  func cellViewModelDidSelect(_ viewModel: ModalCalculationCellViewModel, type: ModalCalculationViewTypes)
}

class ModalCalculationCellViewModel {
  // MARK: - Properties
  weak var delegate: ModalCalculationCellViewModelDelegate?
  
  var iconImage: UIImage? {
    return type.iconImage
  }
  
  private let type: ModalCalculationViewTypes
  
  // MARK: - Init
  init(type: ModalCalculationViewTypes) {
    self.type = type
  }
  
  // MARK: - Public methods
  func select() {
    delegate?.cellViewModelDidSelect(self, type: type)
  }
}

private extension Constants {
  static let previousArrowImage = "arrow.clockwise"
}
