//
//  MockKeychain.swift
//  seekmaxCodetestTests
//
//  Created by pohz on 19/02/2024.
//

import Foundation
@testable import seekmaxCodetest

class MockKeychain: KeychainWrapper {
  
  var didCallGetData = false
  var stubbedData: String?
  func getData(key: String) -> String? {
    didCallGetData = true
    return stubbedData
  }
  
  var didCallSetData = false
  func setData(key: String, value: String) {
    didCallSetData = true
  }
  
  var didCallRemoveData = false
  func removeData(key: String) {
    didCallRemoveData = true
  }
}
