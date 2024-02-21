//
//  ProfileViewModel.swift
//  WalletApp
//

import UIKit

class ProfileViewModel {
  // MARK: - Properties
  private(set) var emptyStateViewModel: EmptyStateViewModel?
  
  private let interactor: ProfileInteractor
  
  // MARK: - Init
  init(interactor: ProfileInteractor) {
    self.interactor = interactor
  }
  
  // MARK: - Public methods
  func viewIsReady() {
    fetchPerson()
  }
  
  // MARK: - Private methods
  private func fetchPerson() {
    emptyStateViewModel = EmptyStateViewModel(image: UIImage(systemName: Constants.emptyViewImage),
                                              imageSize: CGSize(width: 120, height: 120),
                                              title: R.string.profile.profileEmptyViewTitle(),
                                              subtitle: R.string.profile.profileEmptyViewSubtitle())
    interactor.getPerson { result in
      switch result {
      case .success(let person):
        // self.person = person
        break
      case .failure(let error):
        print("Failed to get persong local with \(error)")
      }
    }
  }
}

// MARK: - Constants
private extension Constants {
  static let emptyViewImage = "exclamationmark.circle.fill"
}
