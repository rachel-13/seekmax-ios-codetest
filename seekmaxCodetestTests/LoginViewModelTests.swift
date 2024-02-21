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
    let expectation = XCTestExpectation(description: "Login succeeds")
    let fakeToken = "jwt"
    mockLoginService.shouldSucceed = true
    mockLoginService.stubbedToken = fakeToken
    
    mockSessionManager.$isLoggedIn.sink { isLoggedIn in
      // Then
      if isLoggedIn {
        expectation.fulfill()
      }
    }.store(in: &cancelleable)
    
    // When
    sut.login(with: "someusername", password: "somepassword")
    wait(for: [expectation], timeout: 3)
  }
  
  func testLoginFail_incorrectUsernamePassword() {
    // Given
    let expectation = XCTestExpectation(description: "Login fails with wrong username and password")
    mockLoginService.shouldSucceed = false
    mockLoginService.stubbedError = .unauthorized
    
    sut.errorMessagePublisher.sink { result in
      // Then
      if result == "Username & password don't match" {
        expectation.fulfill()
      }
    }.store(in: &cancelleable)
    
    // When
    sut.login(with: "someusername", password: "somepassword")
    wait(for: [expectation], timeout: 3)
  }
  
  func testLoginFail_networkErrors() {
    // Given
    let expectation = XCTestExpectation(description: "Login fails with unknown error")
    mockLoginService.shouldSucceed = false
    
    sut.errorMessagePublisher.sink { result in
      // Then
      if result == "Something went wrong. Please try again later" {
        expectation.fulfill()
      }
    }.store(in: &cancelleable)
    
    // When
    sut.login(with: "someusername", password: "somepassword")
    wait(for: [expectation], timeout: 3)
  }
}
