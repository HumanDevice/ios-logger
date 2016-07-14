//
//  ViewController.swift
//  HDLoggerExample
//
//  Created by Mikołaj Styś on 14.07.2016.
//  Copyright © 2016 Human Device Sp. z.o.o. All rights reserved.
//

import UIKit
import HDLogger

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    Log.verbose("vvv")
    Log.debug("ddd")
    Log.info("inf")
    Log.warning("www")
    Log.error("err")
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

