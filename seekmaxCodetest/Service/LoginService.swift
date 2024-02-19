//
//  LoginService.swift
//  seekmaxCodetest
//
//  Created by pohz on 18/02/2024.
//

import Foundation
import Combine
import SeekAPI
import Apollo

protocol LoginService {
  var loginStream: PassthroughSubject<Result<String, LoginError>, Never> { get }
  func login(username: String, password: String)
}

enum LoginError: Error {
  case unauthorized
}

class LoginServiceImpl: LoginService {
 
  let loginStream: PassthroughSubject<Result<String, LoginError>, Never> = PassthroughSubject()
  let client: NetworkClient
  
  init(client: NetworkClient) {
    self.client = client
  }
  
  func login(username: String, password: String) {
    
    self.client.apollo.perform(mutation: LoginMutation(username: username, password: password)) { [weak self] result in
      switch result {
      case .success(let response):
        guard let self = self else {
          return
        }
        
        guard response.errors == nil else {
          handleError(errors: response.errors)
          return
        }
        
        guard let token = response.data?.auth else {
          return
        }
        self.loginStream.send(.success(token))
        
      case .failure(let err):
        print(err)
        break
      }
    }
  }
  
  private func handleError(errors: [GraphQLError]?) {
    guard let errors = errors, let firstErr = errors.first?.message else { return }
    self.loginStream.send(.failure(.unauthorized))
  }
}
