//
//  KeychainService.swift
//  seekmaxCodetest
//
//  Created by pohz on 19/02/2024.
//

import Foundation
import KeychainSwift

protocol KeychainWrapper {
  func getData(key: String) -> String?
  func setData(key: String, value: String)
  func removeData(key: String)
}

class KeychainWrapperImpl: KeychainWrapper {
  
  let keychainSwift = KeychainSwift()
  
  init() {
    
  }
  
  func getData(key: String) -> String? {
    return self.keychainSwift.get(key)
  }
  
  func setData(key: String, value: String) {
    self.keychainSwift.set(value, forKey: key)
  }
  
  func removeData(key: String) {
    self.keychainSwift.delete(key)
  }
}
