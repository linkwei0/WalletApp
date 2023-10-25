//
//  APIClient.swift
//  WalletApp
//

import Foundation

protocol APIClient {
  var session: URLSession { get }
  func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?,
                           completion: @escaping (Result<T, APIError>) -> Void)
}

extension APIClient {
  typealias CompletionHandler = (Result<Decodable, APIError>) -> Void
  
  private func decodingTask<T: Decodable>(with request: URLRequest, decodingType: T.Type,
                                          completion: @escaping CompletionHandler) -> URLSessionDataTask {
    let task = session.dataTask(with: request) { data, response, _ in
      guard let httpResponse = response as? HTTPURLResponse else {
        completion(.failure(.requestFailed))
        return
      }
      guard 200..<300 ~= httpResponse.statusCode else {
        completion(.failure(APIError(response: httpResponse)))
        return
      }
      guard let data = data else {
        completion(.failure(.invalidData))
        return
      }
      do {
        let decoder = JSONDecoder()
        let model = try decoder.decode(decodingType, from: data)
        completion(.success(model))
      } catch {
        completion(.failure(.requestFailed))
      }
    }
    
    return task
  }
  
  func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?,
                           completion: @escaping (Result<T, APIError>) -> Void) {
    let task = decodingTask(with: request, decodingType: T.self) { result in
      DispatchQueue.main.async {
        switch result {
        case .success(let json):
          if let value = decode(json) {
            completion(.success(value))
          } else {
            completion(.failure(.requestFailed))
          }
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
    
    task.resume()
  }
}
