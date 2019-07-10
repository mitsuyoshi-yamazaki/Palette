//
//  DataExtensions.swift
//  Palette
//
//  Created by Yamazaki Mitsuyoshi on 2019/07/09.
//  Copyright © 2019 Mitsuyoshi Yamazaki. All rights reserved.
//

import UIKit

public struct BitmapData {
  public typealias Bit = UInt32  // TODO: Add validation
  
  public let data: [Bit]
  public let size: (width: Int, height: Int)
  
  public func sorted(with order: (Bit, Bit) -> Bool) -> BitmapData {

    let newBitmap = data.sorted(by: order)
    return BitmapData.init(data: newBitmap, size: size)
  }
}

public extension UIImage {
  var bitmapRepresentable: BitmapData? {
    guard let cgImage = cgImage else { return nil }
    let width = cgImage.width
    let height = cgImage.height
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    guard let rawdata = calloc(height*width*4, MemoryLayout<CUnsignedChar>.size) else { return nil }
    let bytesPerPixel = 4
    let bytesPerRow = bytesPerPixel * width
    let bitsPerComponent = 8
    let bitmapInfo: UInt32 = CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue

    guard let context = CGContext(data: rawdata, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo) else {
      print("CGContext creation failed")
      return nil
    }
    
    context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
    
    let dataLength = height * width
    let bitmap: [BitmapData.Bit] = (0..<dataLength).map { pixelIndex in
      let byteIndex = pixelIndex * bytesPerPixel
      let r = BitmapData.Bit(rawdata.load(fromByteOffset: byteIndex, as: UInt8.self))
      let g = BitmapData.Bit(rawdata.load(fromByteOffset: byteIndex + 1, as: UInt8.self))
      let b = BitmapData.Bit(rawdata.load(fromByteOffset: byteIndex + 2, as: UInt8.self))

      return r << 16 + g << 8 + b
    }
    
    free(rawdata)
    
    return BitmapData.init(data: bitmap, size: (Int(size.width), Int(size.height)))
  }
  
  // FixMe: Not working: UIImage(data:) returns nil
  convenience init?(bitmapData: BitmapData) {
    let data = Data.init(bytes: bitmapData.data, count: bitmapData.data.count)
    self.init(data: data, scale: 1)
  }
  
  func resize(to ratio: CGFloat) -> UIImage? {
    let resizedSize = CGSize(width: size.width * ratio, height: size.height * ratio)
    
    UIGraphicsBeginImageContext(resizedSize)
    draw(in: CGRect(origin: .zero, size: resizedSize))
    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return resizedImage
  }
}

public extension UIColor {
  convenience init(bit: BitmapData.Bit) {
    let hexR = (bit & 0xff0000) >> 16
    let hexG = (bit & 0xff00) >> 8
    let hexB = (bit & 0xff) >> 0
    
    let r = CGFloat(hexR) / CGFloat(0xff)
    let g = CGFloat(hexG) / CGFloat(0xff)
    let b = CGFloat(hexB) / CGFloat(0xff)
    
    self.init(red: r, green: g, blue: b, alpha: 1.0)
  }
}
