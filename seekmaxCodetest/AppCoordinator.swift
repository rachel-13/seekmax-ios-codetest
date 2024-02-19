//
//  AppCoordinator.swift
//  seekmaxCodetest
//
//  Created by pohz on 18/02/2024.
//

import Foundation
import UIKit

protocol Coordinator {
  func start()
}

class AppCoordinator: Coordinator {
  var window: UIWindow
  var loginCoordinator: LoginCoordinator?
  var tabCoordinator: TabBarCoordinator?
  
  init(window: UIWindow) {
    self.window = window
  }
  
  deinit {
    print("app coordinator deinited")
  }
  
  func start() {
    let navigationController = UINavigationController()
    if let _ = KeychainWrapperImpl().getData(key: Constant.Keychain.accessTokenKey) {
      tabCoordinator = TabBarCoordinator(window: self.window, navigationController: navigationController)
      tabCoordinator?.start()
    } else {
      loginCoordinator = LoginCoordinator(window: self.window, navigationController: navigationController)
      loginCoordinator?.start()
    }
  }
}
