//
//  CurrencyDescription.swift
//  WalletApp
//

import UIKit

extension CurrencyModel {
  enum CurrencyDescription: String, CaseIterable {
    case rub = "Российский рубль"
    case usd = "Доллар США"
    case euro = "Евро"
    
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
  }
}
