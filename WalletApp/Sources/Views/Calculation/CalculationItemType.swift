//
//  CalculationItemType.swift
//  WalletApp
//

import UIKit

enum CalculationItemType: Int {
  case zero, one, two, three, four, five, six, seven, eight, nine, equal, minus,
       plus, multiply, divide, point, plusMinus, resetValues, percent, previousValue
  
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
    case .point:
      return "."
    case .plusMinus:
      return ""
    case .resetValues:
      return "AC"
    case .percent:
      return "%"
    case .previousValue:
      return "back"
    }
  }
  
  var tintColor: UIColor {
    switch self {
    case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .point, .previousValue:
      return UIColor.baseWhite
    case .equal, .minus, .plus, .multiply, .divide:
      return UIColor.accentRedFaded
    case .plusMinus, .resetValues, .percent:
      return UIColor.accentRedLight
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
      return UIImage(systemName: "equal")
    case .minus:
      return UIImage(systemName: "minus")
    case .plus:
      return UIImage(systemName: "plus")
    case .multiply:
      return UIImage(systemName: "multiply")
    case .divide:
      return UIImage(systemName: "divide")
    case .point:
      return R.image.commaButton()
    case .plusMinus:
      return UIImage(systemName: "plus.forwardslash.minus")
    case .resetValues:
      return UIImage(systemName: "xmark.circle")
    case .percent:
      return UIImage(systemName: "percent")
    case .previousValue:
      return UIImage(systemName: "arrow.clockwise")
    }
  }
  
  var isSign: Bool {
    switch self {
    case .minus, .plus, .multiply, .divide:
      return true
    default:
      return false
    }
  }
  
  var isNumber: Bool {
    switch self {
    case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
      return true
    default:
      return false
    }
  }
  
  var isPoint: Bool {
    switch self {
    case .point:
      return true
    default:
      return false
    }
  }
  
  var isEqual: Bool {
    switch self {
    case .equal:
      return true
    default:
      return false
    }
  }
}
