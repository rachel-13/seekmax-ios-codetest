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
  let sessionManager: SessionManagerProtocol
  private var cancellables: Set<AnyCancellable> = []
  
  init(service: LoginService, sessionManager: SessionManagerProtocol) {
    self.service = service
    self.sessionManager = sessionManager
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
    sessionManager.login(with: token)
  }
  
  private func handleError(error: LoginServiceError) {
    switch error {
    case .unauthorized:
      self.errorMessage = "Username & password don't match"
    case .unknown:
      self.errorMessage = "Something went wrong. Please try again later"
    }
  }
  
  private func resetErrorMessage() {
    if !errorMessage.isEmpty {
      errorMessage = ""
    }
  }
}
