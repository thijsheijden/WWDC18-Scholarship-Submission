import UIKit
import PlaygroundSupport

public class CanvasView: UIView {
    
    var lineColor: UIColor!
    var lineWidth: CGFloat!
    
    var path: UIBezierPath!
    var touchPoint: CGPoint!
    var startPoint: CGPoint!
    
    public override func layoutSubviews() {
        setupDefaultSettings()
    }
    
    // control touches
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            startPoint = touch.location(in: self)
            path = UIBezierPath()
            path.move(to: startPoint)
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            touchPoint = touch.location(in: self)
        }
        
        path.addLine(to: touchPoint)
        startPoint = touchPoint
        
        drawShapeLayer()
    }
    
    // Function to clear the drawn path
    func clearCanvas() {
        guard let path = path else { return }
        path.removeAllPoints()
        layer.sublayers = nil
        setNeedsDisplay()
    }
    
    // draw shape on layer
    public func drawShapeLayer() {
        guard let path = path else { return }
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        layer.addSublayer(shapeLayer)
        setNeedsDisplay()
    }
    
    public func setupDefaultSettings() {
        lineColor = .black
        lineWidth = 5
        
        clipsToBounds = true
        isMultipleTouchEnabled = false
    }
    
}



