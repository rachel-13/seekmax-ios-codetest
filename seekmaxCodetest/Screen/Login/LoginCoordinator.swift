//
//  LoginCoordinator.swift
//  seekmaxCodetest
//
//  Created by pohz on 19/02/2024.
//

import Foundation
import UIKit

class LoginCoordinator: Coordinator {
  
  let window: UIWindow
  let navigationController: UINavigationController

  init(window: UIWindow, navigationController: UINavigationController) {
    self.window = window
    self.navigationController = navigationController
  }
  
  deinit {
    print("login coordinator deinited")
  }
  
  func start() {
    let loginService = LoginServiceImpl(client: NetworkClient.shared)
    let loginViewModel = LoginViewModelImpl(service: loginService, sessionManager: SessionManager.shared)
    let loginViewController = LoginViewController(viewModel: loginViewModel)
    
    loginViewModel.coordinatorDelegate = self
    navigationController.viewControllers = [loginViewController]
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
    UIView.transition(with: window,
                      duration: Theme.Duration.animation,
                      options: .transitionCrossDissolve,
                      animations: nil,
                      completion: nil)
  }
}

