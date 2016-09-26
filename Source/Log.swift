//
//  Log.swift
//  logger
//
//  Created by Mikołaj Styś on 10.07.2016.
//  Copyright © 2016 Mikołaj Styś. All rights reserved.
//

import Foundation

/**
 Main class responsible for logging.
 */
open class Log {
  
  static let sharedInstance = Log()
  
  /// Config used for log formatting
  var config: LogConfig = LogConfig()
  
  fileprivate var dateFormatter: DateFormatter = DateFormatter()
  
  fileprivate init() {
    dateFormatter.locale = Locale.current
  }
  
  /**
   Class used by specified instance of logger to create string message that will be printed out
   - parameter logData: data that log will be created from
  */
  func createLog(_ logData: LogData) {
    guard config.enableLogging && logData.logLevel.rawValue >= config.logLevel.rawValue else { return }
    
    var message = ""
    if config.showTime {
      dateFormatter.dateFormat = "HH:mm:ss.SSS"
      message += "\(dateFormatter.string(from: Date())) "
    }
    
    if config.showLevel {
      message += "\(logData.logLevel): "
    }
    
    if config.showThread {
      message += "[\(logData.thread)]"
    }
    if let lastBraceIndex = logData.file.range(of: ".", options:NSString.CompareOptions.backwards)?.last
      , config.showFile {
      message += "\((logData.file.substring(to: lastBraceIndex) as NSString).lastPathComponent)"
    }
    
    if let lastBraceIndex = logData.function.range(of: "(", options:NSString.CompareOptions.backwards)?.last
      , config.showFunction {
      message += ".\(logData.function.substring(to: lastBraceIndex))"
    }
    if config.showLineNumber {
      message += "(\(logData.lineNumber))"
    }
    message += ":\(logData.message)"
    LogQueue.post(message)
  }
  
  /**
   Function creates **LogData** object from received data and notifies all logger instances
  */
  open class func log(_ level: LogLevel, message: Any, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
    sharedInstance.createLog(LogData(message: message, file: fileName, logLevel: level, thread: determineThread(), lineNumber: lineNumber, function: functionName, time: Date()))
  }
  
  fileprivate static func determineThread() -> String {
    var thread = ""
    if Thread.isMainThread {
      thread = "main"
    } else {
      if let threadName = Thread.current.name , !threadName.isEmpty {
        thread = threadName
      } else if let queueName = String(validatingUTF8: DISPATCH_CURRENT_QUEUE_LABEL.label) , !queueName.isEmpty {
        thread = queueName
      } else {
        thread = String(format:"%p", Thread.current)
      }
    }
    return thread
  }
  
  open class func verbose(_ message: Any, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
    log(.verbose, message: message, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
  }
  
  open class func debug(_ message: Any, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
    log(.debug, message: message, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
  }
  
  open class func info(_ message: Any, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
    log(.info, message: message, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
  }
  
  open class func warning(_ message: Any, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
    log(.warning, message: message, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
  }
  
  open class func error(_ message: Any, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
    log(.error, message: message, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
  }
  
}
