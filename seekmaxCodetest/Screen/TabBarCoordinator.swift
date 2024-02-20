//
//  TabBarCoordinator.swift
//  seekmaxCodetest
//
//  Created by pohz on 19/02/2024.
//

import Foundation
import UIKit

class TabBarCoordinator: Coordinator {
  
  let window: UIWindow
  let navigationController: UINavigationController
  
  init(window: UIWindow, navigationController: UINavigationController) {
    self.window = window
    self.navigationController = navigationController
    self.navigationController.navigationBar.isHidden = true
  }
  
  func start() {
    let tabVC = TabBarViewController()
    navigationController.viewControllers = [tabVC]
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
    UIView.transition(with: window,
                      duration: Theme.Duration.animation,
                      options: .transitionCrossDissolve,
                      animations: nil,
                      completion: nil)
  }
}
