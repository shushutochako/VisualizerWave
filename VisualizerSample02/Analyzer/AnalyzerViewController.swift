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
  @IBOutlet weak var audioPlot2: EZAudioPlot!
  

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.audioPlot.color = UIColor(red: 149/255.0, green: 255/255.0, blue: 239/255.0, alpha: 1)
    self.audioPlot.plotType  = .Rolling
    self.audioPlot.shouldFill = true
    self.audioPlot.shouldMirror = true
    self.audioPlot.gain = 20.0

    self.audioPlot2.color = UIColor(red: 149/255.0, green: 255/255.0, blue: 239/255.0, alpha: 1)
    self.audioPlot2.plotType  = .Rolling
    self.audioPlot2.shouldFill = true
    self.audioPlot2.shouldMirror = true

    MicrophoneInputConverter.sharedInstance.delegate = self
    MicrophoneInputConverter.sharedInstance.startFetchingAudio()
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    MicrophoneInputConverter.sharedInstance.stopFetchingAudio()
  }
  
  func dispatch_async_main(block: () -> ()) {
    dispatch_async(dispatch_get_main_queue(), block)
  }
  
  func doubleByte(buffer: UnsafeMutablePointer<Float>, length: UInt32) {
    for i in 0...Int(length)  {
      buffer[i] = buffer[i] * 20
    }
  }
}

extension AnalyzerViewController : MicrophoneInputConverterDelegate {
  func onInputMicrophoneDate(buffer: UnsafeMutablePointer<UnsafeMutablePointer<Float>>, bufferSize: UInt32) {
    //self.doubleByte(buffer[0], length: bufferSize)
    dispatch_async_main {
      self.audioPlot.updateBuffer(buffer[0], withBufferSize: bufferSize)
    }
  }
}
