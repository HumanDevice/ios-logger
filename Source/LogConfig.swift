//
//  LogConfig.swift
//  logger
//
//  Created by Mikołaj Styś on 10.07.2016.
//  Copyright © 2016 Mikołaj Styś. All rights reserved.
//

import Foundation

public struct LogConfig {
  
  var timeFormat: String = "HH:mm:ss.SSS"
  var enableLogging: Bool = true
  var logLevel: LogLevel = .Verbose
  var showThread: Bool = false
  var showLineNumber: Bool = true
  var showFile: Bool = true
  var showFunction: Bool = false
  var showTime: Bool = true
  var showColors: Bool = true
  var showLevel: Bool = true
  var logLevelColors: [LogLevel: ConsoleColor] = [:]
  
  init() {
    logLevelColors[.Verbose] = ConsoleColor.lightGray
    logLevelColors[.Debug] = ConsoleColor.darkGray
    logLevelColors[.Info] = ConsoleColor()
    logLevelColors[.Warning] = ConsoleColor.blue
    logLevelColors[.Error] = ConsoleColor.red
  }
  
}

public struct LogData {
  var message: Any
  var file: String
  var logLevel: LogLevel
  var thread: String
  var lineNumber: Int
  var function: String
  var time: NSDate
}

public enum LogLevel: Int {
  
  case Verbose = 1
  case Debug = 2
  case Info = 3
  case Warning = 4
  case Error = 5
}