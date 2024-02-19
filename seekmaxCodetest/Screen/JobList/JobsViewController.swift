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
    tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tv.separatorStyle = .none
    return tv
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
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
}

extension JobsViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
    cell.textLabel?.text = "Test"
    cell.detailTextLabel?.text = "Detail"
    cell.layer.borderColor = UIColor.black.cgColor
    cell.layer.cornerRadius = 10.0
    cell.layer.shadowOffset = CGSize(width: 5, height: 5)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120.0
  }
}

