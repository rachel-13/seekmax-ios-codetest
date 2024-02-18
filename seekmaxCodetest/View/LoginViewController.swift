//
//  LoginViewController.swift
//  seekmaxCodetest
//
//  Created by pohz on 17/02/2024.
//

import UIKit

class LoginViewController: UIViewController {
  
  lazy var headline: UILabel = {
    let lbl = UILabel().withAutoLayout()
    lbl.text = "Welcome to SeekMax!\nPlease login to proceed"
    lbl.numberOfLines = 0
    lbl.lineBreakMode = .byWordWrapping
    lbl.textAlignment = .center
    return lbl
  }()
  
  lazy var username: UITextField = {
    let tf = UITextField().withAutoLayout()
    tf.placeholder = "Username"
    tf.borderStyle = .roundedRect
    tf.autocapitalizationType = .none
    return tf
  }()
  
  lazy var password: UITextField = {
    let tf = UITextField().withAutoLayout()
    tf.placeholder = "Password"
    tf.borderStyle = .roundedRect
    tf.isSecureTextEntry = true
    return tf
  }()
  
  lazy var loginButton: UIButton = {
    let btn = UIButton().withAutoLayout()
    btn.setTitle("Login", for: .normal)
    btn.backgroundColor = .blue
    btn.layer.cornerRadius = 10.0
    return btn
  }()
  
  lazy var errorMessage: UILabel = {
    let lbl = UILabel().withAutoLayout()
    lbl.text = "Error Message"
    lbl.numberOfLines = 0
    lbl.lineBreakMode = .byWordWrapping
    lbl.textAlignment = .center
    return lbl
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    setupUI()
  }
  
  private func setupUI() {
    self.view.addSubview(headline)
    self.view.addSubview(username)
    self.view.addSubview(password)
    self.view.addSubview(errorMessage)
    self.view.addSubview(loginButton)
    
    NSLayoutConstraint.activate([
      headline.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: self.view.frame.width * 0.2),
      headline.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      headline.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Theme.Dimension.Margin),
      headline.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Theme.Dimension.Margin),
      
      username.topAnchor.constraint(equalTo: self.headline.bottomAnchor, constant: Theme.Dimension.Margin),
      username.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      username.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Theme.Dimension.Margin),
      username.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Theme.Dimension.Margin),
      
      password.topAnchor.constraint(equalTo: self.username.bottomAnchor, constant: Theme.Dimension.Margin),
      password.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      password.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Theme.Dimension.Margin),
      password.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Theme.Dimension.Margin),
      
      errorMessage.topAnchor.constraint(equalTo: self.password.bottomAnchor, constant: Theme.Dimension.Margin),
      errorMessage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      errorMessage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Theme.Dimension.Margin),
      errorMessage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Theme.Dimension.Margin),
      
      loginButton.topAnchor.constraint(greaterThanOrEqualTo: self.errorMessage.bottomAnchor, constant: Theme.Dimension.Margin),
      loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Theme.Dimension.Margin),
      loginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Theme.Dimension.Margin),
    ])
  }
  
}
