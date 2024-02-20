//
//  JobsViewController.swift
//  seekmaxCodetest
//
//  Created by pohz on 17/02/2024.
//

import UIKit
import Combine

class JobsViewController: UIViewController {
  
  lazy var tableView: UITableView = {
    let tv = UITableView().withAutoLayout()
    tv.delegate = self
    tv.dataSource = self
    tv.register(JobListTableViewCell.self, forCellReuseIdentifier: Constant.UI.jobCell)
    tv.separatorStyle = .none
    tv.showsVerticalScrollIndicator = false
    return tv
  }()
  
  let viewModel: JobListViewModel
  var cancellable = Set<AnyCancellable>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    bindToViewModel()
    viewModel.fetchJobs()
  }
  
  init(viewModel: JobListViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  private func bindToViewModel() {
    self.viewModel.cellViewModelPublisher
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _ in
        self?.reloadData()
      }.store(in: &cancellable)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    self.tableView.rowHeight = UITableView.automaticDimension
    self.tableView.estimatedRowHeight = 250
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
    return viewModel.cellViewModels.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.UI.jobCell, for: indexPath) as? JobListTableViewCell else {
      fatalError("Unable to dequeue cell")
    }
    cell.configure(with: viewModel.cellViewModels[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.didTapJob(index: indexPath.row)
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row == viewModel.cellViewModels.count - 2, viewModel.hasNext {
      viewModel.fetchJobs()
    }
  }
}

