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
  let windowScene: UIWindowScene
  
  init(window: UIWindow, windowScene: UIWindowScene) {
    self.window = window
    self.windowScene = windowScene
  }
  
  func start() {
    let keychain = KeychainWrapperImpl()
    let loginService = LoginServiceImpl(client: NetworkClient.shared)
    let loginViewModel = LoginViewModelImpl(service: loginService, keychain: keychain)
    let loginViewController = LoginViewController(viewModel: loginViewModel)
    let navigationController = UINavigationController()
    navigationController.viewControllers = [loginViewController]
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
    window.windowScene = windowScene
  }
}
