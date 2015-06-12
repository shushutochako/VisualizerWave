//
//  MicrophoneInputConverter.swift
//  Pittsburgh
//
//  Created by nobuyasu masujima on 5/28/15.
//  Copyright (c) 2015 cyberagent. All rights reserved.
//

import UIKit

protocol MicrophoneInputConverterDelegate {
  /**
  マイク入力（整形後のデータ）を取得した時の処理
  
  :param: volumeLebel 音量を使いやすいように変換した値
  */
  //func onInputMicrophoneDate(volumeLebel: Int)
  func onInputMicrophoneDate(buffer: UnsafeMutablePointer<UnsafeMutablePointer<Float>>, bufferSize: UInt32)
}

class MicrophoneInputConverter: NSObject {
  
  static let sharedInstance = MicrophoneInputConverter()
  
  var microphone = EZMicrophone()
  var delegate: MicrophoneInputConverterDelegate?
  
  private override init() {
    super.init()
    self.microphone = EZMicrophone(delegate: self)
  }
  
  /**
  マイク入力の検知を開始する
  */
  func startFetchingAudio() {
    self.microphone.startFetchingAudio()
  }

  /**
  マイク入力の検知を終了する
  */
  func stopFetchingAudio() {
    self.microphone.stopFetchingAudio()
  }
  
  // TODO:分かりやすい状態に変換
  private func convertInputDate(buffer: UnsafeMutablePointer<UnsafeMutablePointer<Float>>, bufferSize: UInt32) -> Int {
    return 1
  }
}

// MARK: - EZMicrophoneDelegate
extension MicrophoneInputConverter : EZMicrophoneDelegate {
  func microphone(microphone: EZMicrophone!, hasAudioReceived buffer: UnsafeMutablePointer<UnsafeMutablePointer<Float>>, withBufferSize bufferSize: UInt32, withNumberOfChannels numberOfChannels: UInt32) {
    self.delegate?.onInputMicrophoneDate(buffer, bufferSize: bufferSize)
  }
  
  func microphone(microphone: EZMicrophone!, hasAudioStreamBasicDescription audioStreamBasicDescription: AudioStreamBasicDescription) {
    EZAudio.printASBD(audioStreamBasicDescription)
  }
  
  func microphone(microphone: EZMicrophone!, hasBufferList bufferList: UnsafeMutablePointer<AudioBufferList>, withBufferSize bufferSize: UInt32, withNumberOfChannels numberOfChannels: UInt32) {
  }
}
