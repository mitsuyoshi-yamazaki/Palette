//
//  DataExtensions.swift
//  Palette
//
//  Created by Yamazaki Mitsuyoshi on 2019/07/09.
//  Copyright © 2019 Mitsuyoshi Yamazaki. All rights reserved.
//

import UIKit

public struct BitmapData {
  public typealias Bit = UInt8  // TODO: Add validation
  
  public let data: [Bit]
  public let size: (width: Int, height: Int)
  
  public func sorted(with order: (Bit, Bit) -> Bool) -> BitmapData {

    let newBitmap = data.sorted(by: order)
    return BitmapData.init(data: newBitmap, size: size)
  }
}

public extension UIImage {
  var bitmapRepresentable: BitmapData? {
    guard let imageData = pngData() else { return nil }
    
    let bitmap: [BitmapData.Bit] = imageData.map { BitmapData.Bit($0) }
    
    return BitmapData.init(data: bitmap, size: (Int(size.width), Int(size.height)))
  }
  
  convenience init?(bitmapData: BitmapData) {
    let data = Data.init(bitmapData.data)
    self.init(data: data)
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
