//
//  ViewController.swift
//  Palette
//
//  Created by Yamazaki Mitsuyoshi on 2019/07/09.
//  Copyright © 2019 Mitsuyoshi Yamazaki. All rights reserved.
//

import UIKit
import Palette

private let refreshInterval = 0.5

internal final class ViewController: UIViewController {

  @IBOutlet private weak var imageView: UIImageView!
  
  private var image: UIImage?
  
  override func viewDidLoad() {
    super.viewDidLoad()

    image = imageView.image
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    let originalImage = #imageLiteral(resourceName: "Demo001")
    let shrinkenImage = originalImage.resize(to: 0.001)
    let bitmap = shrinkenImage!.bitmapRepresentable!

    print(bitmap)
    
    //    let alteredBitmap = bitmap.sorted { (l, r) -> Bool in
    //      return l < r
    //    }
    let alteredBitmap = bitmap
    print(alteredBitmap)
    
    let d = Data.init(alteredBitmap.data)
    print(d)
    print(UIImage.init(data: d))

    let alteredImage = UIImage.init(bitmapData: bitmap)
    
    imageView.image = alteredImage

    
//    startProcessing() // FixMe: It does NOT assume that it will be called multiple times
  }
}

private extension ViewController {
  func startProcessing() {
    
    _ = Timer.scheduledTimer(withTimeInterval: refreshInterval, repeats: true, block: { [weak self] _ in
      DispatchQueue.main.async {
        guard let image = self?.imageView.image else { return }
        
        self?.imageView.image = self?.convert(image: image)
      }
    })
  }
  
  func convert(image: UIImage) -> UIImage? {
    guard let imageData = image.pngData() else { return nil }
    
    return image
  }
}
