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
  var recorder: AVAudioRecorder?
  var player: AVAudioPlayer?
  var delegate: AudioInputDelegate?
  
  override init() {
    super.init()
    self.setup()
  }
  
  func setup() {
    AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
    
    let settings = [AVSampleRateKey:NSNumber(float: 44100.0),AVFormatIDKey:NSNumber(integer: kAudioFormatAppleLossless),
      AVNumberOfChannelsKey:NSNumber(int: 2), AVEncoderAudioQualityKey:NSNumber(integer: AVAudioQuality.Min.rawValue)]
    
    var error: NSError?
    let url = NSURL(string: "/dev/null")
    
//    let dirPaths =
//    NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
//						.UserDomainMask, true)
//    let docsDir = dirPaths[0] as! String
//    let soundFilePath =
//    docsDir.stringByAppendingPathComponent("sound.caf")
//    let soundFileURL = NSURL(fileURLWithPath: soundFilePath)
    
    self.recorder = AVAudioRecorder(URL: url, settings: settings as [NSObject : AnyObject], error: &error)
    
    let displaylink = CADisplayLink(target: self, selector: "updateMeters")
    displaylink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)

  }
  
  func startInput() {
    self.recorder!.prepareToRecord()
    self.recorder!.meteringEnabled = true
    self.recorder!.record()
  }
  
  func stopInput() {
    self.recorder!.stop()
  }
  
  func updateMeters() {
    self.recorder!.updateMeters()
    let normalizedValue = pow (5, self.recorder!.averagePowerForChannel(0) / 20)
    self.delegate?.onInputAudio(normalizedValue)
  }
}
