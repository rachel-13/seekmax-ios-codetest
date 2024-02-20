//
//  LoginViewModel.swift
//  seekmaxCodetest
//
//  Created by pohz on 18/02/2024.
//

import Foundation
import Combine

protocol LoginViewModel {
  var errorMessagePublisher: Published<String>.Publisher { get }
  func login(with username: String, password: String)
}

class LoginViewModelImpl: LoginViewModel {
  @Published var errorMessage: String = ""
  var errorMessagePublisher: Published<String>.Publisher { $errorMessage }
  
  let service: LoginService
  let keychain: KeychainWrapper
  weak var coordinatorDelegate: LoginCoordinator?
  private var cancellables: Set<AnyCancellable> = []
  
  init(service: LoginService, keychain: KeychainWrapper) {
    self.service = service
    self.keychain = keychain
    bindToService()
  }
  
  private func bindToService() {
    self.service.loginStream
      .receive(on: DispatchQueue.main)
      .sink { [weak self] result in
        guard let self = self else { return }
        switch result {
        case .success(let token):
          self.saveToken(token: token)
          self.coordinatorDelegate?.didLoginSucceed()
        case .failure(let err):
          self.handleError(error: err)
        }
      }.store(in: &cancellables)
  }
  
  func login(with username: String, password: String) {
    resetErrorMessage()
    self.service.login(username: username, password: password)
  }
  
  private func saveToken(token: String) {
    self.keychain.setData(key: Constant.Keychain.accessTokenKey, value: token)
  }
  
  private func handleError(error: LoginError) {
    if error == .unauthorized {
      self.errorMessage = "Username & password don't match"
    }
  }
  
  private func resetErrorMessage() {
    if !errorMessage.isEmpty {
      errorMessage = ""
    }
  }
}
