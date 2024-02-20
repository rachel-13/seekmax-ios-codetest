//
//  TabBarViewController.swift
//  seekmaxCodetest
//
//  Created by pohz on 17/02/2024.
//

import UIKit

class TabBarViewController: UITabBarController {
  
  lazy var jobsViewController: JobsViewController = {
    let jobService = JobServiceImpl(client: NetworkClient.shared)
    let jobsViewModel = JobListViewModelImpl(service: jobService)
    let jobsViewController = JobsViewController(viewModel: jobsViewModel)
    let jobsBarItem = UITabBarItem(title: "Jobs",
                                   image: UIImage(systemName: "bag"),
                                   selectedImage: UIImage(named: "bag.fill"))
    jobsViewController.tabBarItem = jobsBarItem
    return jobsViewController
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
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
