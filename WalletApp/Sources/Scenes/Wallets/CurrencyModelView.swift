//
//  CurrencyModelView.swift
//  WalletApp
//

import UIKit

struct CurrencyModelView {
  enum WalletsCurrencyType: String, CaseIterable {
    case usd
    case euro
    case rub
    
    init?(rawValue: String) {
      switch rawValue {
      case Constants.rubTitle:
        self = .rub
      case Constants.dollarTitle:
        self = .usd
      case Constants.euroTitle, "EUR":
        self = .euro
      default:
        self = .rub
      }
    }
    
    var title: String {
      switch self {
      case .usd:
        return "$"
      case .euro:
        return "€"
      case .rub:
        return "₽"
      }
    }
        
    var iconImage: UIImage? {
      switch self {
      case .usd:
        return UIImage(systemName: Constants.dollarImage)
      case .euro:
        return UIImage(systemName: Constants.euroImage)
      case .rub:
        return UIImage(systemName: Constants.rubImage)
      }
    }
  }
  
  enum CreateWalletCurrencySegmentedControl: Int, CaseIterable {
    case rub
    case usd
    case euro
    
    init?(rawValue: String) {
      switch rawValue {
      case Constants.rubTitle:
        self = .rub
      case Constants.dollarTitle:
        self = .usd
      case Constants.euroTitle, "EUR":
        self = .euro
      default:
        self = .rub
      }
    }
    
    var iconImage: UIImage? {
      switch self {
      case .rub:
        return UIImage(systemName: Constants.rubImage)
      case .usd:
        return UIImage(systemName: Constants.dollarImage)
      case .euro:
        return UIImage(systemName: Constants.euroImage)
      }
    }
    
    var currencyType: String {
      switch self {
      case .rub:
        return Constants.rubTitle
      case .usd:
        return Constants.dollarTitle
      case .euro:
        return Constants.euroTitle
      }
    }
  }
  
  var value: Double
  var isIncrease: Bool

  let code: String
  let description: String
}

private extension Constants {
  static let dollarImage = "dollarsign"
  static let euroImage = "eurosign"
  static let rubImage = "rublesign"
  
  static let dollarTitle = "USD"
  static let euroTitle = "EURO"
  static let rubTitle = "RUB"
}
