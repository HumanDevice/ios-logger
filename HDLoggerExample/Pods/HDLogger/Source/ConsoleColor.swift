//
//  ConsoleColor.swift
//  logger
//
//  Created by Mikołaj Styś on 10.07.2016.
//  Copyright © 2016 Mikołaj Styś. All rights reserved.
//

import UIKit

public struct ConsoleColor: CustomStringConvertible, CustomDebugStringConvertible {
  
  public static let escape = "\u{001b}["
  public static let clearForegroundColor = "\(escape)fg;"
  public static let clearBackgroundColor = "\(escape)bg;"
  public static let clearColor = "\(escape);"
  
  public var foregroundColor: (Int, Int, Int)? = nil
  public var backgroundColor: (Int, Int, Int)? = nil
  
  public var description: String {
    return format()
  }
  
  public var debugDescription: String {
    return format()
  }
  
  public func format() -> String {
    guard foregroundColor != nil || backgroundColor != nil else {
      // neither set, return reset value
      return ConsoleColor.clearColor
    }
    
    var format: String = ""
    
    if let foregroundColor = foregroundColor {
      format += "\(ConsoleColor.escape)fg\(foregroundColor.0),\(foregroundColor.1),\(foregroundColor.2);"
    }
    else {
      format += ConsoleColor.clearForegroundColor
    }
    
    if let backgroundColor = backgroundColor {
      format += "\(ConsoleColor.escape)bg\(backgroundColor.0),\(backgroundColor.1),\(backgroundColor.2);"
    }
    else {
      format += ConsoleColor.clearBackgroundColor
    }
    
    return format
  }
  
  public init(foregroundColor: (Int, Int, Int)? = nil, backgroundColor: (Int, Int, Int)? = nil) {
    self.foregroundColor = foregroundColor
    self.backgroundColor = backgroundColor
  }
  
  public init(foregroundColor: UIColor, backgroundColor: UIColor? = nil) {
    var redComponent: CGFloat = 0
    var greenComponent: CGFloat = 0
    var blueComponent: CGFloat = 0
    var alphaComponent: CGFloat = 0
    
    foregroundColor.getRed(&redComponent, green: &greenComponent, blue: &blueComponent, alpha:&alphaComponent)
    self.foregroundColor = (Int(redComponent * 255), Int(greenComponent * 255), Int(blueComponent * 255))
    
    if let backgroundColor = backgroundColor {
      backgroundColor.getRed(&redComponent, green: &greenComponent, blue: &blueComponent, alpha:&alphaComponent)
      self.backgroundColor = (Int(redComponent * 255), Int(greenComponent * 255), Int(blueComponent * 255))
    }
  }
  
  public static let red: ConsoleColor = {
    return ConsoleColor(foregroundColor: (255, 0, 0))
  }()
  
  public static let green: ConsoleColor = {
    return ConsoleColor(foregroundColor: (0, 255, 0))
  }()
  
  public static let blue: ConsoleColor = {
    return ConsoleColor(foregroundColor: (0, 0, 255))
  }()
  
  public static let black: ConsoleColor = {
    return ConsoleColor(foregroundColor: (0, 0, 0))
  }()
  
  public static let white: ConsoleColor = {
    return ConsoleColor(foregroundColor: (255, 255, 255))
  }()
  
  public static let lightGray: ConsoleColor = {
    return ConsoleColor(foregroundColor: (211, 211, 211))
  }()
  
  public static let darkGray: ConsoleColor = {
    return ConsoleColor(foregroundColor: (169, 169, 169))
  }()
  
  public static let orange: ConsoleColor = {
    return ConsoleColor(foregroundColor: (255, 165, 0))
  }()
  
  public static let whiteOnRed: ConsoleColor = {
    return ConsoleColor(foregroundColor: (255, 255, 255), backgroundColor: (255, 0, 0))
  }()
  
  public static let darkGreen: ConsoleColor = {
    return ConsoleColor(foregroundColor: (0, 128, 0))
  }()
  
}