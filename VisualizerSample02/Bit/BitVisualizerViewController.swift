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
  var isStart = false;
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func tapButton(sender: AnyObject) {
    if !self.isStart {
      self.blockVisiualizerView.startAnimation()
    } else {
      self.blockVisiualizerView.stopAnimation()
    }
    self.isStart = !self.isStart
  }
}
