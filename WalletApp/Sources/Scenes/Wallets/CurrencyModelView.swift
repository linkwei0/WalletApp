//
//  CurrencyModelView.swift
//  WalletApp
//

import UIKit

struct CurrencyModelView {
  enum WalletsCurrencyType: String {
    case usd = "USD"
    case euro = "EUR"
    
    var iconImage: UIImage? {
      switch self {
      case .usd:
        return UIImage(systemName: "dollarsign")
      case .euro:
        return UIImage(systemName: "eurosign")
      }
    }
  }
  
  enum CreateWalletCurrencyType: Int, CaseIterable {
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
