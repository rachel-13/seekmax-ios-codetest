//
//  seekmaxCodetestTests.swift
//  seekmaxCodetestTests
//
//  Created by pohz on 17/02/2024.
//

import XCTest
import Combine
@testable import seekmaxCodetest

final class seekmaxCodetestTests: XCTestCase {
  
  var sut: LoginViewModelImpl!
  var mockLoginService: MockLoginService!
  var mockSessionManager: MockSessionManager!
  var cancelleable = Set<AnyCancellable>()
  
  override func setUp() {
    mockLoginService = MockLoginService()
    mockSessionManager = MockSessionManager()
    sut = LoginViewModelImpl(service: mockLoginService, sessionManager: mockSessionManager)
  }
  
  func testLoginSuccessful() {
    // Given
    let fakeToken = "jwt"
    mockLoginService.shouldSucceed = true
    mockLoginService.stubbedToken = fakeToken
    
    let _ = sut.service.loginStream.sink { _ in
      // Then
      XCTAssertTrue(self.mockSessionManager.didCallLogin)
      XCTAssertEqual(self.mockSessionManager.stubbedToken, fakeToken)
    }
    
    // When
    sut.login(with: "someusername", password: "somepassword")
  }
  
  func testLoginFail_incorrectUsernamePassword() {
    // Given
    mockLoginService.shouldSucceed = false
    mockLoginService.stubbedError = .unauthorized
    
    let _ = sut.service.loginStream.sink { _ in
      // Then
      XCTAssertFalse(self.mockSessionManager.didCallLogin)
      XCTAssertEqual(self.sut.errorMessage, "Username & password don't match")
    }
    
    // When
    sut.login(with: "someusername", password: "somepassword")
  }
  
  func testLoginFail_networkErrors() {
    // Given
    mockLoginService.shouldSucceed = false
    
    let _ = sut.service.loginStream.sink { _ in
      // Then
      XCTAssertFalse(self.mockSessionManager.didCallLogin)
      XCTAssertEqual(self.sut.errorMessage, "Something went wrong. Please try again later")
    }
    
    // When
    sut.login(with: "someusername", password: "somepassword")
  }
}
