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
  
  init(window: UIWindow) {
    self.window = window
  }
  
  func start() {
    let navigationController = UINavigationController()
    let loginCoordinator = LoginCoordinator(window: self.window, navigationController: navigationController)
    loginCoordinator.start()
  }
}
