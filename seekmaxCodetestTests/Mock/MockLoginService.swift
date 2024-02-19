//
//  MockLoginService.swift
//  seekmaxCodetestTests
//
//  Created by pohz on 19/02/2024.
//

import Foundation
import Combine
@testable import seekmaxCodetest

class MockLoginService: LoginService {
  
  var shouldSucceed = true
  var loginStream = PassthroughSubject<Result<String, LoginError>, Never>()
  func login(username: String, password: String) {
    if shouldSucceed {
      loginStream.send(.success("sometoken"))
    } else {
      loginStream.send(.failure(.unauthorized))
    }
  }
}
