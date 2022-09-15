//
//  CommonButtonStyle.swift
//  WalletApp
//

import UIKit

enum CommonButtonStyle {
  case `default`, clear, small
  
  var backgroudColor: UIColor {
    switch self {
    case .default, .small:
      return .accent
    case .clear:
      return .clear
    }
  }
  
  var highlightedBackgroundColor: UIColor {
    switch self {
    case .default, .small:
      return .accentFaded
    case .clear:
      return .clear
    }
  }
  
  var disabledBackgroundColor: UIColor {
    switch self {
    case .default, .small:
      return .shade2
    case .clear:
      return .clear
    }
  }
  
  var textColor: UIColor {
    switch self {
    case .default, .small:
      return .baseWhite
    case .clear:
      return .accent
    }
  }
  
  var highlightedTextColor: UIColor {
    switch self {
    case .default, .small:
      return .baseWhite
    case .clear:
      return .accentFaded
    }
  }
  
  var disabledTextColor: UIColor {
    switch self {
    case .default, .small:
      return .baseWhite
    case .clear:
      return .shade2
    }
  }
  
  var height: CGFloat {
    switch self {
    case .default, .clear:
      return 48
    case .small:
      return 32
    }
  }
  
  var font: UIFont? {
    switch self {
    case .default, .clear:
      return .bodyBold
    case .small:
      return .footnoteBold
    }
  }
}
