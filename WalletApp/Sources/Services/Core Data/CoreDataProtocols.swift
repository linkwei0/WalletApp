//
//  CoreDataProtocols.swift
//  WalletApp
//
//  Created by Артём Бацанов on 14.05.2023.
//

import Foundation

protocol CurrentBankProtocol {
  func fetchCurrentBank() -> WalletEntity?
}
