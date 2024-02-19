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
    lbl.text = "Login to Seekmax"
    lbl.numberOfLines = 0
    lbl.lineBreakMode = .byWordWrapping
    lbl.textAlignment = .center
    lbl.textColor = Theme.Color.white
    lbl.font = Theme.Font.title
    return lbl
  }()
  
  lazy var username: UITextField = {
    let tf = UITextField().withAutoLayout()
    tf.placeholder = "Username"
    tf.borderStyle = .roundedRect
    tf.autocapitalizationType = .none
    tf.font = Theme.Font.body
    return tf
  }()
  
  lazy var password: UITextField = {
    let tf = UITextField().withAutoLayout()
    tf.placeholder = "Password"
    tf.borderStyle = .roundedRect
    tf.isSecureTextEntry = true
    tf.font = Theme.Font.body
    return tf
  }()
  
  lazy var loginButton: UIButton = {
    let btn = UIButton().withAutoLayout()
    btn.setTitle("Login", for: .normal)
    btn.setTitleColor(Theme.Color.white, for: .normal)
    btn.setTitleColor(Theme.Color.textPrimary, for: .highlighted)
    btn.titleLabel?.font = Theme.Font.button
    btn.backgroundColor = Theme.Color.button
    btn.layer.cornerRadius = 10.0
    btn.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    return btn
  }()
  
  lazy var errorMessage: UILabel = {
    let lbl = UILabel().withAutoLayout()
    lbl.text = "Error Message"
    lbl.numberOfLines = 0
    lbl.lineBreakMode = .byWordWrapping
    lbl.textAlignment = .center
    lbl.font = Theme.Font.body
    lbl.textColor = Theme.Color.errorRed
    return lbl
  }()
  
  let viewModel: LoginViewModel
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = Theme.Color.backgroundBrand
    setupUI()
  }
  
  init(viewModel: LoginViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @IBAction func didTapLogin() {
    viewModel.login(with: username.text ?? "",
                    password: password.text ?? "")
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
      username.heightAnchor.constraint(equalToConstant: Theme.Dimension.TextFieldHeight),
      
      password.topAnchor.constraint(equalTo: self.username.bottomAnchor, constant: Theme.Dimension.Margin),
      password.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      password.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Theme.Dimension.Margin),
      password.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Theme.Dimension.Margin),
      password.heightAnchor.constraint(equalToConstant: Theme.Dimension.TextFieldHeight),
      
      errorMessage.topAnchor.constraint(equalTo: self.password.bottomAnchor, constant: Theme.Dimension.Margin),
      errorMessage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      errorMessage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Theme.Dimension.Margin),
      errorMessage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Theme.Dimension.Margin),
      
      loginButton.topAnchor.constraint(greaterThanOrEqualTo: self.errorMessage.bottomAnchor, constant: Theme.Dimension.Margin),
      loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Theme.Dimension.Margin),
      loginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Theme.Dimension.Margin),
      loginButton.heightAnchor.constraint(equalToConstant: Theme.Dimension.ButtonHeight)
    ])
  }
  
}
