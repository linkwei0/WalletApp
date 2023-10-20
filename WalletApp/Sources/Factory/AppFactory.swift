//
//  AppFactory.swift
//  WalletApp
//

import Foundation

protocol HasWalletsFactory {
  var walletsFactory: WalletsFactoryProtocol { get }
}

protocol HasCreateWalletFactory {
  var createWalletFactory: CreateWalletFactoryProtocol { get }
}

protocol HasWalletDetailFactory {
  var walletDetailFactory: WalletDetailFactoryProtocol { get }
}

final class AppFactory {
  private let walletsFactoryService: WalletsFactory
  private let createWalletFactoryService: CreateWalletFactory
  private let walletDetailFactoryService: WalletDetailFactory
  
  init() {
    walletsFactoryService = WalletsFactory()
    createWalletFactoryService = CreateWalletFactory()
    walletDetailFactoryService = WalletDetailFactory()
  }
}

// MARK: - HasWalletsFactory
extension AppFactory: HasWalletsFactory {
  var walletsFactory: WalletsFactoryProtocol {
    return walletsFactoryService
  }
}

// MARK: - HasCreateWalletFactory
extension AppFactory: HasCreateWalletFactory {
  var createWalletFactory: CreateWalletFactoryProtocol {
    return createWalletFactoryService
  }
}

// MARK: - HasWalletDetailFactory
extension AppFactory: HasWalletDetailFactory {
  var walletDetailFactory: WalletDetailFactoryProtocol {
    return walletDetailFactoryService
  }
}
