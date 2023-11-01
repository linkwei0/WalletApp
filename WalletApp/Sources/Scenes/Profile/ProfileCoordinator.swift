//
//  ProfileCoordinator.swift
//  WalletApp
//

import UIKit

class ProfileCoordinator: Coordinator {
  var childCoordinator: [Coordinator] = []
  var onDidFinish: (() -> Void)?
  
  let navigationController: NavigationController
  let appFactory: AppFactory
  
  required init(navigationController: NavigationController, appFactory: AppFactory) {
    self.navigationController = navigationController
    self.appFactory = appFactory
  }
  
  func start(_ animated: Bool) {
    showProfileScreen(animated: animated)
  }
  
  private func showProfileScreen(animated: Bool) {
    let local = LocalDataSource(coreDataStack: CoreDataStack())
    let remote = RemoteDataSource()
    let useCase = UseCaseProvider(localDataSource: local, remoteDataSource: remote)
    let profileInteractor = ProfileInteractor(useCaseProvider: useCase)
    let profileVM = ProfileViewModel(interactor: profileInteractor)
    let profileVC = ProfileViewController(viewModel: profileVM)
    navigationController.pushViewController(profileVC, animated: animated)
  }
}
