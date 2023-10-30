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
      case "EUR", "EURO":
        self = .euro
      case "USD":
        self = .usd
      case "RUB":
        self = .rub
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
        return UIImage(systemName: "dollarsign")
      case .euro:
        return UIImage(systemName: "eurosign")
      case .rub:
        return UIImage(systemName: "rublesign")
      }
    }
  }
  
  enum CreateWalletCurrencySegmentedControl: Int, CaseIterable {
    case rub
    case usd
    case euro
    
    var iconImage: UIImage? {
      switch self {
      case .rub:
        return UIImage(systemName: "rublesign")
      case .usd:
        return UIImage(systemName: "dollarsign")
      case .euro:
        return UIImage(systemName: "eurosign")
      }
    }
    
    var currencyType: String {
      switch self {
      case .rub:
        return "RUB"
      case .usd:
        return "USD"
      case .euro:
        return "EURO"
      }
    }
  }
  
  var value: Double
  var isIncrease: Bool

  let code: String
  let description: String
}
