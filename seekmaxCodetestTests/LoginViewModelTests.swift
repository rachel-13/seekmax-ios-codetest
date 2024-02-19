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
  var mockKeychain: MockKeychain!
  var cancelleable = Set<AnyCancellable>()
  
  override func setUp() {
    mockLoginService = MockLoginService()
    mockKeychain = MockKeychain()
    sut = LoginViewModelImpl(service: mockLoginService, keychain: mockKeychain)
  }
  
  func testLoginSuccessful() {
    // Given
    mockLoginService.shouldSucceed = true
    
    sut.service.loginStream.sink { _ in
      // Then
      XCTAssertTrue(self.mockKeychain.didCallSetData)
    }
    
    // When
    sut.login(with: "someusername", password: "somepassword")
  }
  
  func testLoginFail() {
    // Given
    mockLoginService.shouldSucceed = false
    
    sut.service.loginStream.sink { _ in
      // Then
      XCTAssertFalse(self.mockKeychain.didCallSetData)
      XCTAssertEqual(self.sut.errorMessage, "Username & password don't match")
    }
    
    // When
    sut.login(with: "someusername", password: "somepassword")
  }
}
