//
//  ViewController.swift
//  Palette
//
//  Created by Yamazaki Mitsuyoshi on 2019/07/09.
//  Copyright © 2019 Mitsuyoshi Yamazaki. All rights reserved.
//

import UIKit

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
    
    startProcessing() // FixMe: It does NOT assume that it will be called multiple times
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

extension Data {
  func imageDescription() -> String {
    return ""
  }
}
