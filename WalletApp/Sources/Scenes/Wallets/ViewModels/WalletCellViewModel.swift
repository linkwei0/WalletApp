//
//  WalletCellViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 16.10.2023.
//

import Foundation

protocol WalletCellViewModelProtocol {
  var name: String { get }
  var currency: String { get }
}

class WalletCellViewModel: WalletCellViewModelProtocol {
  let name: String
  let currency: String
  
  init(_ wallet: WalletModel) {
    self.name = wallet.name
    self.currency = wallet.currency
  }
}
