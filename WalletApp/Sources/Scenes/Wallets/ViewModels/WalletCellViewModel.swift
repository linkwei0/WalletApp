//
//  WalletCellViewModel.swift
//  WalletApp
//

import Foundation

protocol WalletCellViewModelProtocol {
  var name: String { get }
  var currencyCode: String { get }
}

class WalletCellViewModel: WalletCellViewModelProtocol {
  var name: String {
    return wallet.name
  }
  
  var currencyCode: String {
    return wallet.currency.code
  }
  
  private let wallet: WalletModel
  
  init(_ wallet: WalletModel) {
    self.wallet = wallet
  }
}
