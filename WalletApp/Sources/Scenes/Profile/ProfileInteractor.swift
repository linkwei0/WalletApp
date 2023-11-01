//
//  ProfileInteractor.swift
//  WalletApp
//
//  Created by Артём Бацанов on 30.10.2023.
//

import Foundation

class ProfileInteractor {
  private let profileUseCase: ProfileUseCaseProtocol
  
  init(useCaseProvider: UseCaseProviderProtocol) {
    profileUseCase = useCaseProvider.profileUseCase()
  }
  
  func getPerson(completion: @escaping (Result<Void, Error>) -> Void) {
    profileUseCase.getPerson(completion: completion)
  }
}
