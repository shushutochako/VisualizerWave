//
//  AnalyzerViewController.swift
//  VisualizerSample02
//
//  Created by 増島 亘康 on 2015/06/11.
//  Copyright (c) 2015年 増島 亘康. All rights reserved.
//

import UIKit

class AnalyzerViewController: ViewController {
  @IBOutlet weak var audioPlot: EZAudioPlot!
  

  override func viewDidLoad() {
    super.viewDidLoad()
    
    //self.audioPlot.color = UIColor(red: 149, green: 255, blue: 239, alpha: 1)
    self.audioPlot.color = UIColor.whiteColor()
    //self.audioPlot.backgroundColor = UIColor.clearColor()
    self.audioPlot.plotType  = .Rolling
    self.audioPlot.shouldFill = true
    self.audioPlot.shouldMirror = true

    MicrophoneInputConverter.sharedInstance.delegate = self
    MicrophoneInputConverter.sharedInstance.startFetchingAudio()
  }
}

extension AnalyzerViewController : MicrophoneInputConverterDelegate {
  func onInputMicrophoneDate(buffer: UnsafeMutablePointer<UnsafeMutablePointer<Float>>, bufferSize: UInt32) {
    self.audioPlot.updateBuffer(buffer[0], withBufferSize: bufferSize)
  }
}
