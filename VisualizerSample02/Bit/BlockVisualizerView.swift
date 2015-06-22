//
//  BlockVisualizerView.swift
//  VisualizerSample02
//
//  Created by 増島 亘康 on 2015/06/22.
//  Copyright (c) 2015年 増島 亘康. All rights reserved.
//

import UIKit

class BlockVisualizerView: UIView {
  
  var plotWidth:CGFloat = 10
  var plotPadding: CGFloat = 5
  var frequency = 10
  
  private var plots           = [BlockPlotView]()
  private var eventCount: Int = 0
  
  func create() {
    let numberOfColumns = Int(self.bounds.width / self.plotWidth)
    var startX: CGFloat = 0
    for var i=0; i<numberOfColumns; i++ {
      let blockPlot = BlockPlotView(frame: CGRectMake(startX, 0, self.plotWidth, self.bounds.height))
      blockPlot.backgroundColor = UIColor.whiteColor()
      self.plots.append(blockPlot)
      self.addSubview(blockPlot)
      startX += self.plotWidth + self.plotPadding
    }
    let displaylink = CADisplayLink(target: self, selector: "updateHeight")
    displaylink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)

  }
  
  func updateHeight() {
    if self.eventCount == self.frequency {
      for plot in self.plots {
        let blockCount = arc4random() % 7 + 1
        plot.updateBit(Int(blockCount))
        self.eventCount = 0
      }
    }
    self.eventCount++
  }
}
