//
//  WalletCellViewModel.swift
//  WalletApp
//

import Foundation

protocol WalletCellViewModelProtocol {
  var name: String { get }
  var currencyCode: String { get }
  func didLongTap()
}

protocol WalletCellViewModelDelegate: AnyObject {
  func cellViewModelDidLongTap(_ viewModel: WalletCellViewModel, wallet: WalletModel)
}

class WalletCellViewModel {
  // MARK: - Properties
  weak var delegate: WalletCellViewModelDelegate?
  
  private let wallet: WalletModel
  
  // MARK: - Init
  init(_ wallet: WalletModel) {
    self.wallet = wallet
  }
  
  // MARK: - Public methods
  func didLongTap() {
    delegate?.cellViewModelDidLongTap(self, wallet: wallet)
  }
}

// MARK: - WalletCellViewModelProtocol
extension WalletCellViewModel: WalletCellViewModelProtocol {
  var name: String {
    return wallet.name
  }
  
  var currencyCode: String {
    return wallet.currency.code
  }
}
