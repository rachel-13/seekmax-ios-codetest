//
//  MockSessionManager.swift
//  seekmaxCodetestTests
//
//  Created by pohz on 21/02/2024.
//

import Foundation
@testable import seekmaxCodetest

class MockSessionManager: SessionManagerProtocol {
  
  var isLoggedInPublisher: Published<Bool>.Publisher { $isLoggedIn }
  @Published var isLoggedIn = false
  
  var stubbedToken = ""
  func login(with token: String) {
    isLoggedIn = true
    stubbedToken = token
  }
  
  var didCallLogout = false
  func logout() {
    isLoggedIn = false
  }
}
