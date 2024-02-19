//
//  TabBarViewController.swift
//  seekmaxCodetest
//
//  Created by pohz on 17/02/2024.
//

import UIKit

class TabBarViewController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let jobsViewController = JobsViewController()
    let jobsBarItem = UITabBarItem(title: "Jobs",
                                   image: UIImage(systemName: "bag"),
                                   selectedImage: UIImage(named: "bag.fill"))
    jobsViewController.tabBarItem = jobsBarItem
    
    let appliedViewController = AppliedJobsViewController()
    let appliedBarItem = UITabBarItem(title: "Show My Applications",
                                   image: UIImage(systemName: "clipboard"),
                                   selectedImage: UIImage(named: "clipboard.fill"))
    appliedViewController.tabBarItem = appliedBarItem
    
    let profileViewController = ProfileViewController()
    let profileBarItem = UITabBarItem(title: "My Profile",
                                   image: UIImage(systemName: "person"),
                                   selectedImage: UIImage(named: "person.fill"))
    profileViewController.tabBarItem = profileBarItem
    
    
    self.tabBar.backgroundColor = .white
    self.tabBar.isTranslucent = false
    self.viewControllers = [jobsViewController, appliedViewController, profileViewController]
  }
}
