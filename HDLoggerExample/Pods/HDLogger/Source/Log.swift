//
//  Log.swift
//  logger
//
//  Created by Mikołaj Styś on 10.07.2016.
//  Copyright © 2016 Mikołaj Styś. All rights reserved.
//

import Foundation

public class Log {
  
  private static let sharedInstance = Log()
  
  var config: LogConfig = LogConfig()
  private var dateFormatter: NSDateFormatter = NSDateFormatter()
  
  private init() {
    dateFormatter.locale = NSLocale.currentLocale()
    checkXcodeColors()
  }
  
  private func checkXcodeColors() {
    if let xcodeColors = NSProcessInfo.processInfo().environment["XcodeColors"] where config.enableLogging {
      config.showColors = xcodeColors == "YES"
    }
  }
  
  func createLog(logData: LogData) {
    guard config.enableLogging && logData.logLevel.rawValue >= config.logLevel.rawValue else { return }
    
    var message = ""
    if config.showColors {
      message += "\(config.logLevelColors[logData.logLevel]!)"
    }
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
    if config.showColors {
      message += ConsoleColor.clearColor
    }
    LogQueue.post(message)
  }
  

  
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