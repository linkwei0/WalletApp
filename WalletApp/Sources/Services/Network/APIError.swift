//
//  APIError.swift
//  WalletApp
//

import Foundation

enum APIError: Error, ErrorDescriptable {
  case notFound
  case networkProblem
  case badRequest
  case requestFailed
  case invalidData
  case unknown(HTTPURLResponse?)
  
  init(response: HTTPURLResponse?) {
    guard let response = response else {
      self = .unknown(nil)
      return
    }
    
    switch response.statusCode {
    case 400:
      self = .badRequest
    case 404:
      self = .notFound
    default:
      self = .unknown(response)
    }
  }
  
  var description: String {
    switch self {
    case .notFound:
      return Constants.NotFound
    case .networkProblem, .unknown:
      return Constants.ServerError
    case .badRequest, .requestFailed, .invalidData:
      return Constants.RequestFailed
    }
  }
}

extension APIError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .notFound:
      return Constants.NotFound
    case .networkProblem, .unknown:
      return Constants.ServerError
    case .badRequest, .requestFailed, .invalidData:
      return Constants.RequestFailed
    }
  }
}

private extension Constants {
  static let ServerError = "Server Error. Please, try again later."
  static let NotFound = "Bad request error."
  static let RequestFailed = "Resquest failed. Please, try again later."
}
