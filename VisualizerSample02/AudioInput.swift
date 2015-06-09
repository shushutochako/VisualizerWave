//
//  AudioInput.swift
//  VisualizerSample02
//
//  Created by 増島 亘康 on 2015/06/08.
//  Copyright (c) 2015年 増島 亘康. All rights reserved.
//

import UIKit
import AVFoundation

protocol AudioInputDelegate {
  func onInputAudio(level: Float)
}

class AudioInput: NSObject {
  
  let sampleRate: Float = 44100.0
  let channelsKey: Int  = 2
  
  var recorder: AVAudioRecorder?
  var player: AVAudioPlayer?
  var delegate: AudioInputDelegate?
  
  override init() {
    super.init()
    self.setup()
  }
  
  func setup() {
    AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
    
    let settings = [AVSampleRateKey:NSNumber(float: sampleRate),AVFormatIDKey:NSNumber(integer: kAudioFormatAppleLossless),
      AVNumberOfChannelsKey:NSNumber(integer: channelsKey), AVEncoderAudioQualityKey:NSNumber(integer: AVAudioQuality.Min.rawValue)]
    
    var error: NSError?
    let url = NSURL(string: "/dev/null")
    
    self.recorder = AVAudioRecorder(URL: url, settings: settings as [NSObject : AnyObject], error: &error)
    let displaylink = CADisplayLink(target: self, selector: "updateMeters")
    displaylink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
  }
  
  func startInput() {
    if let recorder = self.recorder {
      recorder.prepareToRecord()
      recorder.meteringEnabled = true
      recorder.record()
    }
  }
  
  func stopInput() {
    if let recorder = self.recorder {
      recorder.stop()
    }
  }
  
  func updateMeters() {
    if let recorder = self.recorder {
      recorder.updateMeters()
      let normalizedValue = pow (5, recorder.averagePowerForChannel(0) / 20)
      self.delegate?.onInputAudio(normalizedValue)
    }
  }
}
