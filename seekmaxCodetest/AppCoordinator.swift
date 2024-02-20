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
     routeToTabBar(navigationController: navigationController)
    } else {
      routeToLogin(navigationController: navigationController)
    }
  }
  
  func routeToLogin(navigationController: UINavigationController) {
    loginCoordinator = LoginCoordinator(window: self.window, navigationController: navigationController)
    loginCoordinator?.start()
  }
  
  func routeToTabBar(navigationController: UINavigationController) {
    tabCoordinator = TabBarCoordinator(window: self.window, navigationController: navigationController)
    tabCoordinator?.start()
  }
}
