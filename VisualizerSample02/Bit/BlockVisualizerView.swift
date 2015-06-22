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
  var plotPadding: CGFloat = 1
  var frequency = 10
  var displayLink: CADisplayLink?
  
  //private var plots = [BlockPlotView]()
  private var plots: [BlockPlotView]?
  private var eventCount: Int = 0
  
  func startAnimation() {
    if self.plots == nil {
      let numberOfColumns = Int(self.bounds.width / self.plotWidth)
      var startX: CGFloat = 0
      self.plots = [BlockPlotView]()
      for var i=0; i<numberOfColumns; i++ {
        let blockPlot = createPlot(CGRectMake(startX, 0, self.plotWidth, self.bounds.height))
        self.plots?.append(blockPlot)
        self.addSubview(blockPlot)
        startX += self.plotWidth + self.plotPadding
      }
    }
    
    self.displayLink = CADisplayLink(target: self, selector: "updateHeight")
    if let displayLink = self.displayLink {
      displayLink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
    }
  }
  
  func stopAnimation() {
    self.stopDisplayLink()
  }
  
  func updateHeight() {
    if let plots = self.plots where self.eventCount == self.frequency {
      for plot in plots {
        let blockCount = arc4random() % 7 + 1
        plot.updateBit(Int(blockCount))
        self.eventCount = 0
      }
    }
    self.eventCount++
  }
  
  private func stopDisplayLink() {
    if let diplayLink = self.displayLink {
      displayLink?.invalidate()
    }
  }
  
  private func createPlot(rect: CGRect) -> BlockPlotView {
    let blockPlot = BlockPlotView(frame: rect)
    blockPlot.backgroundColor = UIColor.whiteColor()
    blockPlot.padding = self.plotPadding
    return blockPlot
  }
  
  deinit {
    self.stopDisplayLink()
  }
  
}
