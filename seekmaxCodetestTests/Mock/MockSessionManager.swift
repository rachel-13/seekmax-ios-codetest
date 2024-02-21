//
//  MockSessionManager.swift
//  seekmaxCodetestTests
//
//  Created by pohz on 21/02/2024.
//

import Foundation
@testable import seekmaxCodetest

class MockSessionManager: SessionManagerProtocol {
  
  var didCallLogin = false
  var stubbedToken = ""
  func login(with token: String) {
    didCallLogin = true
    stubbedToken = token
  }
  
  var didCallLogout = false
  func logout() {
    didCallLogout = true
  }
}
