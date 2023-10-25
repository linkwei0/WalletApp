//
//  ErrorDescriptable.swift
//  WalletApp
//

import Foundation

protocol Descriptable {
  var description: String { get }
}

protocol ErrorDescriptable: Descriptable {}
