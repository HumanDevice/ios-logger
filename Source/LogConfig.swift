//
//  LogConfig.swift
//  logger
//
//  Created by Mikołaj Styś on 10.07.2016.
//  Copyright © 2016 Mikołaj Styś. All rights reserved.
//

import Foundation

/**
 Struct that hold data that enables HDLogger configurability.
 */
public struct LogConfig {
  
  var timeFormat: String = "HH:mm:ss.SSS"
  var enableLogging: Bool = true
  var logLevel: LogLevel = .verbose
  var showThread: Bool = false
  var showLineNumber: Bool = true
  var showFile: Bool = true
  var showFunction: Bool = false
  var showTime: Bool = true
  var showLevel: Bool = true
  
  init() {
  }
  
}

/**
 Data related to particular log message that will be printed
 */
public struct LogData {
  var message: Any
  var file: String
  var logLevel: LogLevel
  var thread: String
  var lineNumber: Int
  var function: String
  var time: Date
}

/**
 Represents available log levels. Numbers states for level priority (smaller number, smaller priority)
 */
public enum LogLevel: Int {
  
  case verbose = 1
  case debug = 2
  case info = 3
  case warning = 4
  case error = 5
}
