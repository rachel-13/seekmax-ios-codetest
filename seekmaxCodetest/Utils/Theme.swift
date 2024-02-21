//
//  Theme.swift
//  seekmaxCodetest
//
//  Created by pohz on 18/02/2024.
//

import Foundation
import UIKit

struct Theme {
  
  struct Duration {
    static let animation = 0.3
  }
  
  struct Dimension {
    static let Margin = 20.0
    static let CellMargin = 10.0
    static let TextFieldHeight = 50.0
    static let ButtonHeight = 45.0
    static let cornerRadius = 10.0
    static let estimatedRowHeight = 250.0
  }
  
  struct Color {
    static let backgroundBrand = UIColor(rgb: 0x0d3880)
    static let backgroundSecondary = UIColor(rgb: 0xeff3fb)
    static let white = UIColor(rgb: 0xffffff)
    static let textPrimary = UIColor(rgb: 0x333a49)
    static let textSecondary = UIColor(rgb: 0x69768c)
    static let button = UIColor(rgb: 0x2765cf)
    static let errorRed = UIColor(rgb: 0xff0000)
    static let lightGrayBackground = UIColor(rgb: 0xe4e6eb)
    static let darkGrayShadow = UIColor(rgb:0x333436)
  }
  
  struct Font {
    public enum Name: String {
      case HelveticaNeue_UltraLightItalic = "HelveticaNeue-UltraLightItalic"
      case HelveticaNeue_Medium = "HelveticaNeue-Medium"
      case HelveticaNeue_MediumItalic = "HelveticaNeue-MediumItalic"
      case HelveticaNeue_UltraLight = "HelveticaNeue-UltraLight"
      case HelveticaNeue_Italic = "HelveticaNeue-Italic"
      case HelveticaNeue_Light = "HelveticaNeue-Light"
      case HelveticaNeue_ThinItalic = "HelveticaNeue-ThinItalic"
      case HelveticaNeue_LightItalic = "HelveticaNeue-LightItalic"
      case HelveticaNeue_Bold = "HelveticaNeue-Bold"
      case HelveticaNeue_Thin = "HelveticaNeue-Thin"
      case HelveticaNeue_CondensedBlack = "HelveticaNeue-CondensedBlack"
      case HelveticaNeue = "HelveticaNeue"
      case HelveticaNeue_CondensedBold = "HelveticaNeue-CondensedBold"
      case HelveticaNeue_BoldItalic = "HelveticaNeue-BoldItalic"
    }
    
    static let title = UIFont(name: Font.Name.HelveticaNeue_Bold.rawValue, size: 24.0)
    static let title2 = UIFont(name: Font.Name.HelveticaNeue_Bold.rawValue, size: 20.0)
    static let title3 = UIFont(name: Font.Name.HelveticaNeue_Bold.rawValue, size: 18.0)
    static let body = UIFont(name: Font.Name.HelveticaNeue.rawValue, size: 18.0)
    static let body2 = UIFont(name: Font.Name.HelveticaNeue.rawValue, size: 16.0)
    static let caption = UIFont(name: Font.Name.HelveticaNeue_Thin.rawValue, size: 16.0)
    static let button = UIFont(name: Font.Name.HelveticaNeue_Bold.rawValue, size: 18.0)
  }
  
}
