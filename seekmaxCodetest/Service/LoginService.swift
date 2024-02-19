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
  var tokenPublisher: Published<String>.Publisher { get }
  func login(username: String, password: String)
}

class LoginServiceImpl: LoginService {
 
  @Published var token: String = ""
  var tokenPublisher: Published<String>.Publisher { $token }
  let client: NetworkClient
  
  init(client: NetworkClient) {
    self.client = client
  }
  
  func login(username: String, password: String) {
    
    self.client.apollo.perform(mutation: LoginMutation(username: username, password: password)) { [weak self] result in
      switch result {
      case .success(let response):
        guard let self = self, let token = response.data?.auth else {
          return
        }
        self.token = token
      case .failure(let err):
        // TODO: handle failed login
        break
      }
    }
    
  }
}
