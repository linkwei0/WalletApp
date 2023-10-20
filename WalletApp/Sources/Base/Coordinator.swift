//
//  Coordinator.swift
//  WalletApp
//

import UIKit

protocol Coordinator: AnyObject {
  init(navigationController: NavigationController, appFactory: AppFactory)
  
  var childCoordinator: [Coordinator] { get set }
  var navigationController: NavigationController { get }
  var appFactory: AppFactory { get }
  var onDidFinish: (() -> Void)? { get set }
  
  func show<T: Coordinator>(_ type: T.Type, animated: Bool) -> T
  func show<T: ConfigurableCoordinator>(_ type: T.Type, configuration: T.Configuration, animated: Bool) -> T
  func startCoordinator(_ coordinator: Coordinator, animated: Bool)
  
  func addPopObserver(for viewController: UIViewController)
  func handleCoordinatorFinished()
  
  func start(_ animated: Bool)
  func add(_ coordinator: Coordinator)
  func remove(_ coordinator: Coordinator)
}

extension Coordinator {
  func add(_ coordinator: Coordinator) {
    childCoordinator.append(coordinator)
  }
  
  func remove(_ coordinator: Coordinator) {
    childCoordinator.removeAll { $0 === coordinator }
  }
  
  @discardableResult
  func show<T: Coordinator>(_ type: T.Type, animated: Bool) -> T {
    let coordinator = T(navigationController: navigationController, appFactory: appFactory)
    startCoordinator(coordinator, animated: animated)
    return coordinator
  }
  
  @discardableResult
  func show<T: ConfigurableCoordinator>(_ type: T.Type, configuration: T.Configuration, animated: Bool) -> T {
    let coordinator = T(navigationController: navigationController,
                        appFactory: appFactory,
                        configuration: configuration)
    startCoordinator(coordinator, animated: animated)
    return coordinator
  }
  
  func startCoordinator(_ coordinator: Coordinator, animated: Bool) {
    add(coordinator)
    coordinator.onDidFinish = { [weak self, weak coordinator] in
      guard let coordinator = coordinator else { return }
      self?.handleCoordinatorFinished()
      self?.remove(coordinator)
    }
    coordinator.start(animated)
  }
  
  func addPopObserver(for viewController: UIViewController) {
    navigationController.addPopObserver(for: viewController, coordinator: self)
  }
  
  func handleCoordinatorFinished() {
    // Do nothing
  }
}
