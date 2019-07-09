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
    
    imageView.image = UIImage.init(named: "Demo001p")
    
    view.addSubview(imageView)
  }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()

