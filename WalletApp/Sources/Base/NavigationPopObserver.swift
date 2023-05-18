//
//  NavigationPopObserver.swift
//  WalletApp
//
//  Created by Артём Бацанов on 15.05.2023.
//

import UIKit

class NavigationPopObserver {
  let observedViewController: UIViewController
  
  private let coordinator: Coordinator
  
  init(observedViewController: UIViewController, coordinator: Coordinator) {
    self.observedViewController = observedViewController
    self.coordinator = coordinator
  }
  
  func didObservePop() {
    coordinator.onDidFinish?()
  }
}
