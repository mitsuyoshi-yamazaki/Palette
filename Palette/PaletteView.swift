//
//  PaletteView.swift
//  Palette
//
//  Created by Yamazaki Mitsuyoshi on 2019/07/10.
//  Copyright © 2019 Mitsuyoshi Yamazaki. All rights reserved.
//

import UIKit

open class PaletteView: UIView {
  open var bitmap: BitmapData? {
    didSet {
      setNeedsDisplay()
    }
  }
  
  override open func draw(_ rect: CGRect) {
    guard let bitmap = bitmap else { return }
    guard let context = UIGraphicsGetCurrentContext() else { return }
    
    let cellSize = frame.size.width / CGFloat(bitmap.size.width)
    
    for y in 0..<bitmap.size.height {
      for x in 0..<bitmap.size.width {
        
        let index = y * bitmap.size.width + x
        let bit = bitmap.data[index]
        let color = UIColor.init(bit: bit)
        context.setFillColor(color.cgColor)
        
        let rect = CGRect.init(x: CGFloat(x) * cellSize,
                               y: CGFloat(y) * cellSize,
                               width: cellSize,
                               height: cellSize)
        context.fill(rect)
      }
    }    
  }
}
