//
//  seekmaxCodetestTests.swift
//  seekmaxCodetestTests
//
//  Created by pohz on 17/02/2024.
//

import XCTest
@testable import seekmaxCodetest

final class seekmaxCodetestTests: XCTestCase {
  
  var sut: LoginViewModelImpl!
  var mockLoginService: MockLoginService!
  var mockKeychain: MockKeychain!
  
  override func setUp() {
    mockLoginService = MockLoginService()
    mockKeychain = MockKeychain()
    sut = LoginViewModelImpl(service: mockLoginService, keychain: mockKeychain)
  }
  
  func testLoginSuccessful() {
    // Given
    mockLoginService.shouldSucceed = true
    
    // When
    sut.login(with: "someusername", password: "somepassword")
    
    // Then
    XCTAssertTrue(mockKeychain.didCallSetData)
  }
}
