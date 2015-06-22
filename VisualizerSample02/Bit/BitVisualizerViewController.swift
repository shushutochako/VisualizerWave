//
//  BitVisualizerViewController.swift
//  VisualizerSample02
//
//  Created by 増島 亘康 on 2015/06/22.
//  Copyright (c) 2015年 増島 亘康. All rights reserved.
//

import UIKit

class BitVisualizerViewController: UIViewController {

  @IBOutlet weak var blockVisiualizerView: BlockVisualizerView!
  
  var timing:Int = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    let displaylink = CADisplayLink(target: self, selector: "updateMeters")
//    displaylink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
    self.blockVisiualizerView.create()
    //self.blockVisiualizerView.updateHeight()
//    self.bitView.updateBit(0)
//    self.bitView02.updateBit(0)
//    self.bitView03.updateBit(0)
  }
  
  func updateMeters() {
    if self.timing == 7 {
//      var meters1 = arc4random() % 7 + 1
//      var meters2 = arc4random() % 7 + 1
//      var meters3 = arc4random() % 7 + 1
//      self.bitView.updateBit(Int(meters1))
//      self.bitView02.updateBit(Int(meters2))
//      self.bitView03.updateBit(Int(meters3))
//      self.timing = 0
      self.blockVisiualizerView.updateHeight()
    }
    self.timing++
  }
}
