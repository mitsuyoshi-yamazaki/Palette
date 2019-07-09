//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport
import Palette

class MyViewController : UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let imageView = UIImageView.init(frame: view.bounds)
    imageView.contentMode = .scaleAspectFill
    imageView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, .flexibleHeight]
    
    let originalImage = UIImage.init(named: "Demo001p")!
    let shrinkenImage = originalImage.resize(to: 0.001)
    let bitmap = shrinkenImage!.bitmapRepresentable!
    print(bitmap)
    
    let alteredBitmap = bitmap.sorted { (l, r) -> Bool in
      return l < r
    }
    print(alteredBitmap)
    
    let d = Data.init(alteredBitmap.data)
    print(d)
    print(UIImage.init(data: d))
    
    let alteredImage = UIImage.init(bitmapData: alteredBitmap)
    
    imageView.image = alteredImage
    
    view.addSubview(imageView)
  }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()


