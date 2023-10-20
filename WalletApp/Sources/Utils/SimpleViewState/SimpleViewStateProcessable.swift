//
//  SimpleViewStateProcessable.swift
//  WalletApp
//
//  Created by Артём Бацанов on 07.08.2023.
//

import Foundation

protocol SimpleViewStateProcessable {
  func processResult<T>(_ entities: [T]) -> SimpleViewState<T>
}

extension SimpleViewStateProcessable {
  func processResult<T>(_ entities: [T]) -> SimpleViewState<T> {
    return entities.isEmpty ? .empty : .populated(entities)
  }
}
