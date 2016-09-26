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
public class Log {
  
  static let sharedInstance = Log()
  
  /// Config used for log formatting
  var config: LogConfig = LogConfig()
  
  private var dateFormatter: NSDateFormatter = NSDateFormatter()
  
  private init() {
    dateFormatter.locale = NSLocale.currentLocale()
  }
  
  /**
   Class used by specified instance of logger to create string message that will be printed out
   - parameter logData: data that log will be created from
  */
  func createLog(logData: LogData) {
    guard config.enableLogging && logData.logLevel.rawValue >= config.logLevel.rawValue else { return }
    
    var message = ""
    if config.showTime {
      dateFormatter.dateFormat = "HH:mm:ss.SSS"
      message += "\(dateFormatter.stringFromDate(NSDate())) "
    }
    
    if config.showLevel {
      message += "\(logData.logLevel): "
    }
    
    if config.showThread {
      message += "[\(logData.thread)]"
    }
    if let lastBraceIndex = logData.file.rangeOfString(".", options:NSStringCompareOptions.BackwardsSearch)?.last
      where config.showFile {
      message += "\((logData.file.substringToIndex(lastBraceIndex) as NSString).lastPathComponent)"
    }
    
    if let lastBraceIndex = logData.function.rangeOfString("(", options:NSStringCompareOptions.BackwardsSearch)?.last
      where config.showFunction {
      message += ".\(logData.function.substringToIndex(lastBraceIndex))"
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
  public class func log(level: LogLevel, message: Any, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
    sharedInstance.createLog(LogData(message: message, file: fileName, logLevel: level, thread: determineThread(), lineNumber: lineNumber, function: functionName, time: NSDate()))
  }
  
  private static func determineThread() -> String {
    var thread = ""
    if NSThread.isMainThread() {
      thread = "main"
    } else {
      if let threadName = NSThread.currentThread().name where !threadName.isEmpty {
        thread = threadName
      } else if let queueName = String(UTF8String: dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL)) where !queueName.isEmpty {
        thread = queueName
      } else {
        thread = String(format:"%p", NSThread.currentThread())
      }
    }
    return thread
  }
  
  public class func verbose(message: Any, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
    log(.Verbose, message: message, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
  }
  
  public class func debug(message: Any, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
    log(.Debug, message: message, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
  }
  
  public class func info(message: Any, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
    log(.Info, message: message, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
  }
  
  public class func warning(message: Any, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
    log(.Warning, message: message, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
  }
  
  public class func error(message: Any, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
    log(.Error, message: message, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
  }
  
}
