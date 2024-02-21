//
//  AppCoordinatorTests.swift
//  seekmaxCodetestTests
//
//  Created by pohz on 21/02/2024.
//

import XCTest
import Combine
@testable import seekmaxCodetest

final class AppCoordinatorTests: XCTestCase {
  
  var sut: AppCoordinator!
  var mockSessionManager: MockSessionManager!
  var cancelleable = Set<AnyCancellable>()
  
  override func setUp() {
    mockSessionManager = MockSessionManager()
    sut = AppCoordinator(window: UIWindow(), sessionManager: mockSessionManager)
  }
  
  func testRouteToLogin() {
    // Given
    mockSessionManager.isLoggedIn = false
    
    // When
    sut.start()
    
    // Then
    XCTAssertNotNil(sut.loginCoordinator)
  }
  
  func testRouteToTabBar() {
    mockSessionManager.isLoggedIn = true
    
    // When
    sut.start()
    
    // Then
    XCTAssertNotNil(sut.tabCoordinator)
  }
  
}
