//
//  JobListCoordinator.swift
//  seekmaxCodetest
//
//  Created by pohz on 20/02/2024.
//

import Foundation
import UIKit

class JobListCoordinator: Coordinator {
  
  let navigationController: UINavigationController
  
  init(navigationController: UINavigationController?) {
    self.navigationController = navigationController ?? UINavigationController()
  }
  
  deinit {
    print("job list coordinator deinited")
  }
  
  func start() {
    let jobService = JobServiceImpl(client: NetworkClient.shared)
    let jobsViewModel = JobListViewModelImpl(service: jobService)
    let jobsViewController = JobsViewController(viewModel: jobsViewModel)
    let jobsBarItem = UITabBarItem(title: "Jobs",
                                   image: UIImage(systemName: "bag"),
                                   selectedImage: UIImage(named: "bag.fill"))
    jobsViewController.tabBarItem = jobsBarItem
    jobsViewModel.coordinatorDelegate = self
    self.navigationController.viewControllers = [jobsViewController]
  }
  
  func showDetailsFor(jobId: String) {
    let jobDetailService = JobServiceImpl(client: NetworkClient.shared)
    let jobDetailViewModel = JobDetailViewModelImpl(jobId: jobId, service: jobDetailService)
    let jobDetailViewController = JobDetailViewController(viewModel: jobDetailViewModel)
    self.navigationController.present(jobDetailViewController, animated: true)
  }
}
