//
//  BlockVisualizerView.swift
//  VisualizerSample02
//
//  Created by 増島 亘康 on 2015/06/22.
//  Copyright (c) 2015年 増島 亘康. All rights reserved.
//

import UIKit

class BlockVisualizerView: UIView {
  
  /*
  * 一マスの幅
  */
  var blockWidth: CGFloat = 10

  /*
  * マスの隙間
  */
  var blockPadding: CGFloat = 1
  
  /*
  * アニメーションの更新頻度(低いほうが頻度が多くなる)
  */
  var frequency: UInt = 10
  
  /*
  * マスの色
  */
  var blockColor = UIColor.blackColor()
  
  private var displayLink: CADisplayLink?
  private var plots: [BlockPlotView]?
  private var eventCount: UInt = 0
  
  /**
  アニメーションを開始する
  */
  func startAnimation() {
    if self.plots == nil {
      let numberOfColumns = Int(self.bounds.width / self.blockWidth)
      var startX: CGFloat = 0
      self.plots = [BlockPlotView]()
      for var i=0; i<numberOfColumns; i++ {
        let blockPlot = createPlot(CGRectMake(startX, 0, self.blockWidth, self.bounds.height))
        self.plots?.append(blockPlot)
        self.addSubview(blockPlot)
        startX += self.blockWidth + self.blockPadding
      }
    }
    
    self.displayLink = CADisplayLink(target: self, selector: "updateHeight")
    if let displayLink = self.displayLink {
      displayLink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
    }
  }
  
  /**
  アニメーションを終了する
  */
  func stopAnimation() {
    self.stopDisplayLink()
  }
  
  func updateHeight() {
    if let plots = self.plots where self.eventCount == self.frequency {
      for plot in plots {
        // TODO: 縦の最大数の算出
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
    blockPlot.padding = self.blockPadding
    blockPlot.blockColor = self.blockColor
    return blockPlot
  }
  
  deinit {
    self.stopDisplayLink()
  }
  
}
