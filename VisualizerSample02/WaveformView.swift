//
//  WaveformView.swift
//  VisualizerSample02
//
//  Created by 増島 亘康 on 2015/06/08.
//  Copyright (c) 2015年 増島 亘康. All rights reserved.
//

import UIKit

class WaveformView: UIView {
    
  var numberOfWaves:Int = 1
  var waveColor = UIColor()
  var primaryWaveLineWidth: CGFloat = 3.0
  var secondaryWaveLineWidth: CGFloat = 1.0
  var idleAmplitude: CGFloat = 0.01
  var frequency: CGFloat = 1.5
  var amplitude: CGFloat = 1.0
  var density: CGFloat = 5.0
  var phaseShift: CGFloat = -0.15
  
  var phase: CGFloat = 0
  
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
    self.phase += self.phaseShift
    self.amplitude = fmax(level, self.idleAmplitude);
    self.setNeedsDisplay()
  }
  
  override func drawRect(rect: CGRect) {
    let context = UIGraphicsGetCurrentContext()
    CGContextClearRect(context, self.bounds)
    
    self.backgroundColor?.set()
    CGContextFillRect(context, rect)
    
    for var i = 0; i < self.numberOfWaves; i++ {
      let context = UIGraphicsGetCurrentContext()
      
      CGContextSetLineWidth(context, (i == 0 ? self.primaryWaveLineWidth : self.secondaryWaveLineWidth))

      var halfHeight = CGRectGetHeight(self.bounds) / 2
      var width = CGRectGetWidth(self.bounds)
      var mid = width / 2
      
      let maxAmplitude = halfHeight - 4.0
      
      let progress = 1 - CGFloat(i) / CGFloat(self.numberOfWaves)
      let normedAmplitude = (1.5 * progress - 0.5) * self.amplitude
      
      let multiplier = min(1.0, (progress / 3.0 * 2.0) + (1.0 / 3.0))
      self.waveColor.colorWithAlphaComponent(multiplier * CGColorGetAlpha(self.waveColor.CGColor)).set()

      for var x: CGFloat = 0; x < (width + self.density); x += self.density {
        let scaling: CGFloat = -pow(1 / mid * (x - mid), 2) + 1
        let a = scaling * maxAmplitude * normedAmplitude
        let b = sinf(Float(CGFloat(2 * M_PI) * (x / width) * self.frequency + self.phase))
        let y = a * CGFloat(b) + halfHeight
        
        if x == 0 {
          CGContextMoveToPoint(context, x, y);
          CGContextAddLineToPoint(context, self.frame.size.width + 200, y);
          CGContextAddLineToPoint(context, 0, 500);
        } else {
          CGContextAddLineToPoint(context, x, y);
        }
      }
      //CGContextStrokePath(context);
      CGContextFillPath(context);
    }
  }

  
}
