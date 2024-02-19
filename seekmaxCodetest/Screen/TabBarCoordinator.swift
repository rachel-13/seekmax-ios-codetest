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
  }
  
  func start() {
    let tabVC = TabBarViewController()
    if navigationController.viewControllers.isEmpty {
      navigationController.viewControllers = [tabVC]
      window.rootViewController = navigationController
      window.makeKeyAndVisible()
    } else {
      tabVC.modalPresentationStyle = .fullScreen
      self.navigationController.present(tabVC, animated: true)
    }
  }
}
