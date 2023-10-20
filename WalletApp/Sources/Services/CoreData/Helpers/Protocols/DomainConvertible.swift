//
//  DomainConvertible.swift
//  WalletApp
//
//  Created by Артём Бацанов on 20.09.2023.
//

import Foundation

protocol DomainConvertible {
  associatedtype Domain
  func asDomain() -> Domain
}
