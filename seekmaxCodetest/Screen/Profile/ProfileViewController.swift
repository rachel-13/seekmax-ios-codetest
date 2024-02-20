//
//  ProfileViewController.swift
//  seekmaxCodetest
//
//  Created by pohz on 17/02/2024.
//

import UIKit

class ProfileViewController: UIViewController {
  
  lazy var logoutButton: UIButton = {
    let btn = UIButton().withAutoLayout()
    btn.backgroundColor = Theme.Color.backgroundBrand
    btn.setTitle("Logout", for: .normal)
    btn.setTitleColor(Theme.Color.white, for: .normal)
    btn.setTitleColor(Theme.Color.textSecondary, for: .highlighted)
    btn.layer.cornerRadius = Theme.Dimension.cornerRadius
    btn.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
    return btn
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  private func setupUI() {
    self.view.backgroundColor = Theme.Color.white
    self.view.addSubview(logoutButton)
    
    NSLayoutConstraint.activate([
      self.logoutButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      self.logoutButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Theme.Dimension.Margin),
      self.logoutButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Theme.Dimension.Margin),
      self.logoutButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
    ])
  }
  
  @IBAction func didTapLogout() {
    SessionManager.shared.logout()
  }
  
}
