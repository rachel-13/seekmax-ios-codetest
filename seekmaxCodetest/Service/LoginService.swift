//
//  LoginService.swift
//  seekmaxCodetest
//
//  Created by pohz on 18/02/2024.
//

import Foundation
import Combine
import SeekAPI

protocol LoginService {
  func login(username: String, password: String)
}

class LoginServiceImpl: LoginService {
  
  let client: NetworkClient
  
  init(client: NetworkClient) {
    self.client = client
  }
  
  func login(username: String, password: String) {
    
    self.client.apollo.perform(mutation: LoginMutation(username: username, password: password)) { [weak self] result in
      switch result {
      case .success(let response):
        // TODO: handle successful login
        break
      case .failure(let err):
        // TODO: handle failed login
        break
      }
    }
    
  }
}
