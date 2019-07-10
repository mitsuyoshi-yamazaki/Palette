//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport
import Palette

let originalImage = UIImage.init(named: "Demo001p")!
let shrinkenImage = originalImage.resize(to: 0.01)!

let png = shrinkenImage.pngData()!
print(png.count)
print(originalImage.size)

let bitmap = shrinkenImage.bitmapRepresentable!

let convertedImage = UIImage.init(bitmapData: bitmap)

class MyViewController : UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupImageView()
//    setupPaletteView()
  }
  
  func setupImageView() {
    let imageView = UIImageView.init(frame: view.bounds)
    imageView.contentMode = .scaleAspectFill
    imageView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, .flexibleHeight]
    imageView.image = convertedImage
    
    view.addSubview(imageView)
  }
  
  func setupPaletteView() {
    let paletteView = PaletteView.init(frame: view.bounds)
    paletteView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, .flexibleHeight]
    view.addSubview(paletteView)
    
    paletteView.bitmap = bitmap
  }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()

print(bitmap.size)
print(bitmap.data)
print(bitmap.data.count)
