//
//  SimpleViewState.swift
//  WalletApp
//
//  Created by Артём Бацанов on 20.06.2023.
//

import Foundation

enum SimpleViewState<Entity> {
  case initial
  case populated([Entity])
  case empty
  case error(Error)
  
  var currentEntities: [Entity] {
    switch self {
    case .populated(let entities):
      return entities
    case .initial, .empty, .error:
      return []
    }
  }
  
  var isInitialPage: Bool {
    switch self {
    case .initial, .populated, .empty, .error:
      return true
    }
  }
}
