//
//  VisualizerViewController.swift
//  VisualizerSample02
//
//  Created by 増島 亘康 on 2015/06/08.
//  Copyright (c) 2015年 増島 亘康. All rights reserved.
//

import UIKit

class VisualizerViewController: UIViewController {

  @IBOutlet weak var waveformView: WaveformView!
  var audioInput = AudioInput()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.audioInput.delegate = self
    self.start()
  }
  func start() {
    self.audioInput.startInput()
  }
}

extension VisualizerViewController : AudioInputDelegate {
  func onInputAudio(level: Float) {
    println(level)
    self.waveformView.update(CGFloat(level))
  }
}
