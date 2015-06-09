//
//  WaveformView.swift
//  VisualizerSample02
//
//  Created by 増島 亘康 on 2015/06/08.
//  Copyright (c) 2015年 増島 亘康. All rights reserved.
//

import UIKit

class WaveformView: UIView {
  
  /*
  * 波の色
  */
  var waveColor = UIColor()
  
  /*
  * 振幅の低限
  */
  var idleAmplitude: CGFloat = 0.01
  
  /*
  * 周波数
  */
  var frequency: CGFloat = 1.5
  
  /*
  * 描画周期
  */
  var density: CGFloat = 5.0
  
  /*
  * 位相変位
  */
  var phaseShift: CGFloat = -0.15
  
  /*
  * 振幅の掛け率(大きくすると反応しやすくなる)
  */
  var amplitudeRate: CGFloat = 1.0
  
  private var phase: CGFloat = 0
  private var amplitude: CGFloat = 1.0
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.setup()
  }
  
  private func setup() {
    self.waveColor = UIColor.blueColor()
  }
  
  func update(level: CGFloat) {
    // オーバーフローしないように適当なところでクリアする
    if self.phase < -200 {
      self.phase = 0
    }
    self.phase += self.phaseShift
    
    if level < self.idleAmplitude {
      self.amplitude = self.idleAmplitude
    } else {
      self.amplitude = min(1,level * self.amplitudeRate)
    }
    self.setNeedsDisplay()
  }
  
  override func drawRect(rect: CGRect) {
    var context = UIGraphicsGetCurrentContext()
    CGContextClearRect(context, self.bounds)
    
    self.backgroundColor?.set()
    CGContextFillRect(context, rect)
    
    context = UIGraphicsGetCurrentContext()
    
    var halfHeight = CGRectGetHeight(self.bounds) / 2
    var width = CGRectGetWidth(self.bounds)
    var mid = width / 2
    
    let maxAmplitude = halfHeight
    self.waveColor.colorWithAlphaComponent(CGColorGetAlpha(self.waveColor.CGColor)).set()
    
    let drawingWidth = width + self.density
    for var x: CGFloat = 0; x < drawingWidth; x += self.density {
      // 波に拡大率(波ごとにブレを発生させる。viewの真ん中で波が最大になるように設定)
      let scaling: CGFloat = -pow(1 / mid * (x - mid), 2) + 1
      // 波の振幅
      let amplitude = scaling * maxAmplitude * self.amplitude
      //println(self.amplitude)
      // 波を繰り返す周期
      let cycle = Float(CGFloat(2 * M_PI) * (x / width) * self.frequency + self.phase)
      
      let y = amplitude * CGFloat(sinf(cycle)) + halfHeight
      if x == 0 {
        // 始点
        CGContextMoveToPoint(context, x, y);
      } else {
        // 波を描画する為のポイント追加
        CGContextAddLineToPoint(context, x, y);
      }
      
    }
    // 塗り潰し範囲確定の為のポイント追加
    CGContextAddLineToPoint(context, self.frame.size.width, halfHeight)
    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height)
    CGContextAddLineToPoint(context, 0, self.frame.size.height)
    CGContextAddLineToPoint(context, 0, halfHeight)
    
    CGContextFillPath(context);
  }
  
  private func getYPoint() {
    
  }

  
}
