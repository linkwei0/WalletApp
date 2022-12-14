//
//  ProfileCoordinator.swift
//  WalletApp
//

import UIKit

class ProfileCoordinator: Coordinator {
  var childCoordinator: [Coordinator] = []
  var onDidFinish: (() -> Void)?
  
  let navigationController: UINavigationController
  let appDependency: AppDependency
  
  
  required init(navigationController: UINavigationController, appDependency: AppDependency) {
    self.navigationController = navigationController
    self.appDependency = appDependency
  }
  
  func start(_ animated: Bool) {
    showProfileScreen(animated: animated)
  }
  
  private func showProfileScreen(animated: Bool) {
    let profileVC = ProfileViewController()
    navigationController.pushViewController(profileVC, animated: animated)
  }
}
