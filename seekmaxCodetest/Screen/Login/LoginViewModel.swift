//
//  LoginViewModel.swift
//  seekmaxCodetest
//
//  Created by pohz on 18/02/2024.
//

import Foundation
import Combine

protocol LoginViewModel {
  func login(with username: String, password: String)
}

class LoginViewModelImpl: LoginViewModel {
  
  let service: LoginService
  let keychain: KeychainWrapper
  private var cancellables: Set<AnyCancellable> = []
  
  init(service: LoginService, keychain: KeychainWrapper) {
    self.service = service
    self.keychain = keychain
    bindToService()
  }
  
  private func bindToService() {
    self.service.tokenPublisher
      .receive(on: DispatchQueue.main)
      .sink { [weak self] token in
        guard let self = self else { return }
        self.keychain.setData(key: Constant.Keychain.accessTokenKey, value: token)
      }.store(in: &cancellables)
  }
  
  func login(with username: String, password: String) {
    self.service.login(username: username, password: password)
  }
}
