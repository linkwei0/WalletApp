//
//  ConfigurableCoordinator.swift
//  WalletApp
//

import Foundation

protocol ConfigurableCoordinator: Coordinator {
  associatedtype Configuration
  init(navigationController: NavigationController, appFactory: AppFactory, configuration: Configuration)
}

extension ConfigurableCoordinator {
  init(navigationController: NavigationController, appFactory: AppFactory) {
    fatalError("Use init with configuration for this coordinator")
  }
}
