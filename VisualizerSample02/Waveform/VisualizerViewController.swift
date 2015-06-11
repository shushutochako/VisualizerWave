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
  @IBOutlet weak var frontWaveformView: WaveformView!

  var audioInput = AudioInput()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.audioInput.delegate = self
    
    self.waveformView.frequency = 2
    self.waveformView.waveColor = UIColor(red: 253/255, green: 181/255, blue: 44/255, alpha: 1)
    self.waveformView.amplitudeRate = 1.5
    
    self.frontWaveformView.alpha = 0.5
    self.frontWaveformView.frequency = 1
    self.frontWaveformView.waveColor = UIColor(red: 255/255, green: 120/255, blue: 230/255, alpha: 1)
    self.frontWaveformView.amplitudeRate = 1.5
    
    self.start()
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    self.audioInput.stopInput()
  }
  
  func start() {
    self.audioInput.startInput()
  }
}

extension VisualizerViewController : AudioInputDelegate {
  func onInputAudio(level: Float) {
    self.waveformView.update(CGFloat(level))
    self.frontWaveformView.update(CGFloat(level))
  }
}
