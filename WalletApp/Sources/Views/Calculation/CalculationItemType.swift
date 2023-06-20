//
//  CalculationItemType.swift
//  WalletApp
//

import UIKit

enum SelectedType {
  case income, expense
}

enum CalculationItemType: Int {
  case clear, zero, one, two, three, four, five,
       six, seven, eight, nine, equal,
       minus, plus, multiply, divide, comma,
       empty, clearAC, percent, back
  
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
    case .minus:
      return "-"
    case .plus:
      return "+"
    case .multiply:
      return "x"
    case .divide:
      return "/"
    case .equal:
      return "="
    case .comma:
      return ","
    case .clear:
      return ""
    case .empty:
      return ""
    case .clearAC:
      return "AC"
    case .percent:
      return "%"
    case .back:
      return "back"
    }
  }
  
  var tintColor: UIColor {
    switch self {
    case .clear:
      return UIColor.baseWhite
    case .zero:
      return UIColor.baseWhite
    case .one:
      return UIColor.baseWhite
    case .two:
      return UIColor.baseWhite
    case .three:
      return UIColor.baseWhite
    case .four:
      return UIColor.baseWhite
    case .five:
      return UIColor.baseWhite
    case .six:
      return UIColor.baseWhite
    case .seven:
      return UIColor.baseWhite
    case .eight:
      return UIColor.baseWhite
    case .nine:
      return UIColor.baseWhite
    case .equal:
      return UIColor.accentRedFaded
    case .minus:
      return UIColor.accentRedFaded
    case .plus:
      return UIColor.accentRedFaded
    case .multiply:
      return UIColor.accentRedFaded
    case .divide:
      return UIColor.accentRedFaded
    case .comma:
      return UIColor.baseWhite
    case .empty:
      return UIColor.baseWhite
    case .clearAC:
      return UIColor.accentRedLight
    case .percent:
      return UIColor.accentRedLight
    case .back:
      return UIColor.baseWhite
    }
  }
  
  var backgroundColor: UIColor {
    switch self {
    default:
      return .accent
    }
  }
  
  var iconImage: UIImage? {
    switch self {
    case .clear:
      return R.image.clearButton()
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
    case .equal:
      return R.image.equalButton()
    case .minus:
      return R.image.minusButton()
    case .plus:
      return R.image.plusButton()
    case .multiply:
      return R.image.multiplyButton()
    case .divide:
      return R.image.divideButton()
    case .comma:
      return R.image.commaButton()
    case .empty:
      return nil
    case .clearAC:
      return R.image.cleanAllButton()
    case .percent:
      return R.image.precentButton()
    case .back:
      return R.image.backButton()
    }
  }
}
