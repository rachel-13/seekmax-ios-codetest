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
  var stubbedToken = ""
  var stubbedError = LoginServiceError.unknown
  var loginStream = PassthroughSubject<Result<String, LoginServiceError>, Never>()
  func login(username: String, password: String) {
    if shouldSucceed {
      loginStream.send(.success(stubbedToken))
    } else {
      loginStream.send(.failure(stubbedError))
    }
  }
}
