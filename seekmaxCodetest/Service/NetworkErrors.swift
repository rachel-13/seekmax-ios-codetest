//
//  NetworkErrors.swift
//  seekmaxCodetest
//
//  Created by pohz on 19/02/2024.
//

import Foundation

enum LoginServiceError: Error {
  case unauthorized
  case unknown
}

enum JobServiceError: Error {
  case unknown
}
