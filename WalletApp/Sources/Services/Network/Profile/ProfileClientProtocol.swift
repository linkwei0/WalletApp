//
//  ProfileClientProtocol.swift
//  WalletApp
//
//  Created by Артём Бацанов on 01.11.2023.
//

import Foundation

protocol ProfileClientProtocol {
  func getPerson(completion: @escaping (Result<Void, Error>) -> Void)
}
