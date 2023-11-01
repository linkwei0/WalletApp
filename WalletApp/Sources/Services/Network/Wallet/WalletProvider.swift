//
//  WalletProvider.swift
//  WalletApp
//

import Foundation

enum WalletProvider {
  case getCurrencies
}

// MARK: - Endpoint
extension WalletProvider: Endpoint {
  var base: String {
    return "https://www.cbr-xml-daily.ru"
  }
  
  var path: String {
    switch self {
    case .getCurrencies:
      return "/daily_json.js"
    }
  }
  
  var headers: [String : String]? {
    return nil
  }
  
  var params: [String : Any]? {
    switch self {
    case .getCurrencies:
      return nil
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .getCurrencies:
      return .get
    }
  }
}
