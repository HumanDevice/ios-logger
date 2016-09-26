//
//  LogQueue.swift
//  logger
//
//  Created by Mikołaj Styś on 10.07.2016.
//  Copyright © 2016 Mikołaj Styś. All rights reserved.
//

import Foundation

/**
 Log Queue for properly log queueing in multithread enviroment
 */
open class LogQueue {
  
  open static let logQueueIdentifier = "com.human-device.ios.logger.queue"
  fileprivate static let sharedInstance = LogQueue()
  fileprivate let queue: DispatchQueue
  
  fileprivate init() {
    queue = DispatchQueue(label: LogQueue.logQueueIdentifier, attributes: [])
  }
  
  ///Posts created log message to queue
  open static func post(_ message: String) {
    let outputClosure = {
      print(message)
    }
    sharedInstance.queue.async(execute: outputClosure)
  }
  
}
