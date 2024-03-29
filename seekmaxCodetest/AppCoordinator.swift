//
//  AppCoordinator.swift
//  seekmaxCodetest
//
//  Created by pohz on 18/02/2024.
//

import Foundation
import UIKit
import Combine

protocol Coordinator {
  func start()
}

class AppCoordinator: Coordinator {
  var window: UIWindow
  var loginCoordinator: LoginCoordinator?
  var tabCoordinator: TabBarCoordinator?
  var cancelleable = Set<AnyCancellable>()
  let sessionManager: SessionManagerProtocol
  
  init(window: UIWindow, sessionManager: SessionManagerProtocol) {
    self.window = window
    self.sessionManager = sessionManager
  }
  
  deinit {
    print("app coordinator deinited")
  }
  
  func start() {
    let navigationController = UINavigationController()
    sessionManager.isLoggedInPublisher
      .sink { isLoggedIn in
        if isLoggedIn {
          self.routeToTabBar(navigationController: navigationController)
        } else {
          self.routeToLogin(navigationController: navigationController)
        }
      }.store(in: &cancelleable)
  }
  
  func routeToLogin(navigationController: UINavigationController) {
    if loginCoordinator == nil {
      loginCoordinator = LoginCoordinator(window: self.window, navigationController: navigationController)
    }
    loginCoordinator?.start()
  }
  
  func routeToTabBar(navigationController: UINavigationController) {
    tabCoordinator = TabBarCoordinator(window: self.window, navigationController: navigationController)
    tabCoordinator?.start()
  }
}
