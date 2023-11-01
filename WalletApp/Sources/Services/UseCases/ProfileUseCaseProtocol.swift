//
//  ProfileUseCaseProtocol.swift
//  WalletApp
//
//  Created by Артём Бацанов on 30.10.2023.
//

import Foundation

protocol ProfileUseCaseProtocol {
  func getPerson(completion: @escaping (Result<Void, Error>) -> Void)
}
