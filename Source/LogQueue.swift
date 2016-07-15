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
public class LogQueue {
  
  public static let logQueueIdentifier = "com.human-device.ios.logger.queue"
  private static let sharedInstance = LogQueue()
  private let queue: dispatch_queue_t
  
  private init() {
    queue = dispatch_queue_create(LogQueue.logQueueIdentifier, nil)
  }
  
  ///Posts created log message to queue
  public static func post(message: String) {
    let outputClosure = {
      print(message)
    }
    dispatch_async(sharedInstance.queue, outputClosure)
  }
  
}