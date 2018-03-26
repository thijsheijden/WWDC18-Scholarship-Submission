import Foundation
import UIKit
import PlaygroundSupport

public class DrawingViewController : UIViewController {
    
    let drawView = UIView()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = UIView()
        self.view = view
        view.backgroundColor = .gray
    
        drawView.backgroundColor = .white
        drawView.layer.cornerRadius = 20
        drawView.frame = CGRect(x: 12.5, y: 200, width: 350, height: 350)
        view.addSubview(drawView)
        
        drawForm()
        
    }
    
    @objc func drawForm() {
        var applePath = Forms.swiftBirdForm()
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.frame = CGRect(x: -120, y: 120, width: 350, height: 350)

        var paths: [UIBezierPath] = applePath
        
        guard let path = paths.first else {
            return
        }

        paths.dropFirst()
            .forEach {
                path.append($0)
        }
        
        shapeLayer.transform = CATransform3DMakeScale(0.6, 0.6, 0)
        shapeLayer.path = path.cgPath
        
        self.view.layer.addSublayer(shapeLayer)

        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.duration = 1.0
        strokeEndAnimation.fromValue = 0.0
        strokeEndAnimation.toValue = 1.0
        shapeLayer.add(strokeEndAnimation, forKey: nil)
    }
    
}
