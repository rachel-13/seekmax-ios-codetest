//
//  JobsViewController.swift
//  seekmaxCodetest
//
//  Created by pohz on 17/02/2024.
//

import UIKit

class JobsViewController: UIViewController {
  
  lazy var tableView: UITableView = {
    let tv = UITableView().withAutoLayout()
    tv.delegate = self
    tv.dataSource = self
    tv.register(JobListTableViewCell.self, forCellReuseIdentifier: Constant.UI.jobCell)
    tv.separatorStyle = .none
    return tv
  }()
  
  var viewModel = JobListViewModelImpl(service: JobServiceImpl(client: NetworkClient.shared))
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    viewModel.vc = self
    viewModel.fetchJobs()
  }
  
  private func setupUI() {
    self.view.backgroundColor = Theme.Color.backgroundBrand
    self.view.addSubview(tableView)
    
    NSLayoutConstraint.activate([
      self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
    ])
  }
  
  func reloadData() {
    tableView.reloadData()
  }
}

extension JobsViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.jobs.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.UI.jobCell, for: indexPath) as? JobListTableViewCell else {
      fatalError("Unable to dequeue cell")
    }
    cell.configure()
    cell.positionTitle.text = viewModel.jobs[indexPath.row]?._id
    cell.positionDesc.text = viewModel.jobs[indexPath.row]?.description
    cell.appliedLabel.text = "Applied"
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 180.0
  }
}

