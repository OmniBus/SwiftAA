//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import SwiftAA

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        view.addSubview(label)
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()

let sun = Sun(julianDay: JulianDay())
sun.polarSemiDiameter

let sun2 = Sun(julianDay: JulianDay() + 180)
sun2.polarSemiDiameter
