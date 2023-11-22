//
//  SimpleViewStateProcessable.swift
//  WalletApp
//

import Foundation

protocol SimpleViewStateProccessable {
  func processResult<T>(_ entities: [T]) -> SimpleViewState<T>
}

extension SimpleViewStateProccessable {
  func processResult<T>(_ entities: [T]) -> SimpleViewState<T> {
    return entities.isEmpty ? .empty : .populated(entities)
  }
}
