//
//  SceneDelegate.swift
//  WalletApp
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  private var mainCoordinator: MainCoordinator?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    mainCoordinator = createMainCoordinator(windowScene)
    mainCoordinator?.start(false)
  }
  
  private func createMainCoordinator(_ scene: UIWindowScene) -> MainCoordinator {
    let window = UIWindow(windowScene: scene)
    let navigationController = NavigationController()
    window.rootViewController = navigationController
    window.backgroundColor = .systemGroupedBackground
    window.makeKeyAndVisible()
    
    self.window = window
    
    return MainCoordinator(navigationController: navigationController)
  }
}
