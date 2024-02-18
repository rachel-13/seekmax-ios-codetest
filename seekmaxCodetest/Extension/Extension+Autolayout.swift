//
//  Extension+Autolayout.swift
//  seekmaxCodetest
//
//  Created by pohz on 18/02/2024.
//

import Foundation
import UIKit

extension UIView {
  func withAutoLayout() -> Self {
    self.translatesAutoresizingMaskIntoConstraints = false
    return self
  }
}
