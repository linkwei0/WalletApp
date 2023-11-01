//
//  RemoteDataSourceProtocol.swift
//  WalletApp
//
//  Created by Артём Бацанов on 01.11.2023.
//

import Foundation

protocol RemoteDataSourceProtocol {
  func walletDataSource() -> WalletRemoteDataSourceProtocol
  func profileDataSource() -> ProfileRemoteDataSourceProtocol
}
