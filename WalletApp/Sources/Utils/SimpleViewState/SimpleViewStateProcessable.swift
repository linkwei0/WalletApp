//
//  SimpleViewStateProcessable.swift
//  WalletApp
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
