//
//  SessionManager.swift
//  seekmaxCodetest
//
//  Created by pohz on 20/02/2024.
//

import Foundation

protocol SessionManagerProtocol {
  var isLoggedInPublisher: Published<Bool>.Publisher { get }
  func login(with token: String)
  func logout()
}

class SessionManager: SessionManagerProtocol {
  var isLoggedInPublisher: Published<Bool>.Publisher { $isLoggedIn }
  @Published var isLoggedIn: Bool = false
  static let shared: SessionManager = SessionManager()
  let keychain = KeychainWrapperImpl()
  
  deinit {
    print("session manager deinited")
  }
  
  private init() {
    if let _ = keychain.getData(key: Constant.Keychain.accessTokenKey) {
      isLoggedIn = true
    }
  }
  
  func login(with token: String) {
    keychain.setData(key: Constant.Keychain.accessTokenKey, value: token)
    isLoggedIn = true
  }
  
  func logout() {
    keychain.removeData(key: Constant.Keychain.accessTokenKey)
    isLoggedIn = false
  }
}
