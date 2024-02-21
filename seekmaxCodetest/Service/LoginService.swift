//
//  LoginService.swift
//  seekmaxCodetest
//
//  Created by pohz on 18/02/2024.
//

import Foundation
import Combine
import SeekmaxAPI
import Apollo

protocol LoginService {
  var loginStream: PassthroughSubject<Result<String, LoginServiceError>, Never> { get }
  func login(username: String, password: String)
}


class LoginServiceImpl: LoginService {
 
  let loginStream: PassthroughSubject<Result<String, LoginServiceError>, Never> = PassthroughSubject()
  let client: NetworkClient
  
  init(client: NetworkClient) {
    self.client = client
  }
  
  func login(username: String, password: String) {
    
    self.client.apollo.perform(mutation: LoginMutation(username: username, password: password)) { [weak self] result in
      guard let self = self else {
        return
      }
      
      switch result {
      case .success(let response):
        guard response.errors == nil else {
          self.handleError(errors: response.errors)
          return
        }
        
        guard let token = response.data?.auth else {
          return
        }
        self.loginStream.send(.success(token))
        
      case .failure(let err):
        self.handleError(errors: [err])
        break
      }
    }
  }
  
  private func handleError(errors: [Error]?) {
    guard let errors = errors else {
      return
    }
    if let graphQLErrs = errors as? [GraphQLError], let firstErrMessage = graphQLErrs.first?.message?.contains("401") {
      self.loginStream.send(.failure(LoginServiceError.unauthorized))
      return
    }
    
    self.loginStream.send(.failure(LoginServiceError.unknown))
  }
}
