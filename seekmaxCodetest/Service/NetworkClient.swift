//
//  NetworkClient.swift
//  seekmaxCodetest
//
//  Created by pohz on 18/02/2024.
//

import Foundation
import Apollo
import ApolloAPI

class NetworkClient {
  static let shared = NetworkClient()
  private(set) lazy var apollo: ApolloClient = {
    guard let url = URL(string: "http://localhost:3002") else {
      fatalError("Invalid URL!")
    }
    return ApolloClient(url: url)
  }()
}
