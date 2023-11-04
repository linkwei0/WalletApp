//
//  ProfileCoordinator.swift
//  WalletApp
//

import UIKit

class ProfileCoordinator: Coordinator {
  typealias Factory = HasProfileFactory
  
  var childCoordinator: [Coordinator] = []
  var onDidFinish: (() -> Void)?
  
  let navigationController: NavigationController
  let appFactory: AppFactory
  
  private let factory: Factory
  
  required init(navigationController: NavigationController, appFactory: AppFactory) {
    self.navigationController = navigationController
    self.appFactory = appFactory
    self.factory = appFactory
  }
  
  func start(_ animated: Bool) {
    showProfileScreen(animated: animated)
  }
  
  private func showProfileScreen(animated: Bool) {
    let profileVC = factory.profileFactory.makeModule()
    profileVC.title = R.string.profile.profileTitle()
    navigationController.pushViewController(profileVC, animated: animated)
  }
}
