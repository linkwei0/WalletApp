//
//  CurrencyDescription.swift
//  WalletApp
//

import UIKit

extension CurrencyModel {
  enum CurrencyDescription: String {
    case usd = "Доллар США"
    case euro = "Евро"
    case rub = "Российский рубль"
    
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
}
