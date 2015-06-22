//
//  BlockPlotView.swift
//  VisualizerSample02
//
//  Created by 増島 亘康 on 2015/06/22.
//  Copyright (c) 2015年 増島 亘康. All rights reserved.
//

import UIKit

class BlockPlotView: UIView {
  
  var meters: Int = 0

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  func updateBit(meters: Int) {
    self.meters = meters
    self.setNeedsDisplay()
  }
  
  override func drawRect(rect: CGRect) {
    var context = UIGraphicsGetCurrentContext()
    CGContextClearRect(context, self.bounds)
    self.backgroundColor?.set()
    CGContextFillRect(context, rect)
    
    context = UIGraphicsGetCurrentContext()
    UIColor.blueColor().colorWithAlphaComponent(CGColorGetAlpha(UIColor.blueColor().CGColor)).set()
    
    var padding:CGFloat = 1
    var startY:CGFloat = self.frame.height
    
    for var i=0; i<self.meters; i++ {
      // 左下
      CGContextMoveToPoint(context, 0, startY)
      // 左上
      CGContextMoveToPoint(context, 0, startY - self.frame.width)
      // 右上
      CGContextAddLineToPoint(context, self.frame.width, startY - self.frame.width)
      // 右下
      CGContextAddLineToPoint(context, self.frame.width, startY)
      // 四角を閉じる為のポイント
      CGContextAddLineToPoint(context, 0, startY)
      
      startY -= padding + self.frame.width
    }
    CGContextFillPath(context);
  }
}
