import Foundation
import UIKit

let macbookBezierPath = UIBezierPath()
let context = UIGraphicsGetCurrentContext()!

open class Forms {
    

public class func MacbookForm() -> [UIBezierPath] {
    
    var forms: [UIBezierPath] = []
    
    let path2 = UIBezierPath()
    path2.move(to: CGPoint(x: 2.94, y: 0))
    path2.addCurve(to: CGPoint(x: 0.02, y: 109.59), controlPoint1: CGPoint(x: 2.94, y: 36.77), controlPoint2: CGPoint(x: -0.26, y: 72.7))
    context.saveGState()
    context.translateBy(x: 70.33, y: 61.08)
    path2.lineWidth = 3
    UIColor.black.setStroke()
    path2.stroke()
    context.restoreGState()
    forms.append(path2)
    
    let path3 = UIBezierPath()
    path3.move(to: CGPoint.zero)
    path3.addCurve(to: CGPoint(x: 183.79, y: 1.07), controlPoint1: CGPoint(x: 54.73, y: 0), controlPoint2: CGPoint(x: 134.4, y: 12.99))
    context.saveGState()
    context.translateBy(x: 71.04, y: 169.2)
    path3.lineWidth = 3
    UIColor.black.setStroke()
    path3.stroke()
    context.restoreGState()
    forms.append(path3)
    
    let path4 = UIBezierPath()
    path4.move(to: CGPoint(x: 0.54, y: 110.45))
    path4.addLine(to: CGPoint.zero)
    context.saveGState()
    context.translateBy(x: 254.47, y: 59.07)
    path4.lineWidth = 3
    UIColor.black.setStroke()
    path4.stroke()
    context.restoreGState()
    forms.append(path4)
    
    let path5 = UIBezierPath()
    path5.move(to: CGPoint.zero)
    path5.addLine(to: CGPoint(x: 178.44, y: 0.45))
    context.saveGState()
    context.translateBy(x: 74.2, y: 59.43)
    path5.lineWidth = 3
    UIColor.black.setStroke()
    path5.stroke()
    context.restoreGState()
    forms.append(path5)
    
    let path6 = UIBezierPath()
    path6.move(to: CGPoint(x: 0.41, y: 2.58))
    path6.addCurve(to: CGPoint(x: 0.49, y: 0.4), controlPoint1: CGPoint(x: 5.03, y: 4.12), controlPoint2: CGPoint(x: 4.73, y: -1.52))
    path6.addCurve(to: CGPoint(x: 2.24, y: 2.35), controlPoint1: CGPoint(x: -1.3, y: 1.21), controlPoint2: CGPoint(x: 2.41, y: 1.4))
    context.saveGState()
    context.translateBy(x: 157.22, y: 63.95)
    path6.lineWidth = 3
    UIColor.black.setStroke()
    path6.stroke()
    context.restoreGState()
    forms.append(path6)
    
    let path7 = UIBezierPath()
    path7.move(to: CGPoint(x: 42.52, y: 0))
    path7.addLine(to: CGPoint(x: 0, y: 78.05))
    context.saveGState()
    context.translateBy(x: 27.41, y: 168.93)
    path7.lineWidth = 3
    UIColor.black.setStroke()
    path7.stroke()
    context.restoreGState()
    forms.append(path7)
    
    let path8 = UIBezierPath()
    path8.move(to: CGPoint(x: 0, y: 7.18))
    path8.addCurve(to: CGPoint(x: 103.15, y: 6.06), controlPoint1: CGPoint(x: 34.38, y: 6.8), controlPoint2: CGPoint(x: 68.78, y: 7.03))
    path8.addCurve(to: CGPoint(x: 143.78, y: 3.09), controlPoint1: CGPoint(x: 116.72, y: 5.67), controlPoint2: CGPoint(x: 130.28, y: 4.6))
    path8.addCurve(to: CGPoint(x: 157.51, y: 0), controlPoint1: CGPoint(x: 148.44, y: 2.57), controlPoint2: CGPoint(x: 152.82, y: -0))
    path8.addCurve(to: CGPoint(x: 203.45, y: 3.14), controlPoint1: CGPoint(x: 172.86, y: 0.01), controlPoint2: CGPoint(x: 188.13, y: 2.09))
    context.saveGState()
    context.translateBy(x: 27.69, y: 239.21)
    path8.lineWidth = 3
    UIColor.black.setStroke()
    path8.stroke()
    context.restoreGState()
    forms.append(path8)
    
    let path9 = UIBezierPath()
    path9.move(to: CGPoint(x: 26.59, y: 0))
    path9.addCurve(to: CGPoint(x: 10.54, y: 36.45), controlPoint1: CGPoint(x: 21.21, y: 27.23), controlPoint2: CGPoint(x: 30.25, y: -13.26))
    path9.addCurve(to: CGPoint(x: 0, y: 72.19), controlPoint1: CGPoint(x: 5.96, y: 47.99), controlPoint2: CGPoint(x: 3.51, y: 60.28))
    context.saveGState()
    context.translateBy(x: 229.44, y: 169.07)
    path9.lineWidth = 3
    UIColor.black.setStroke()
    path9.stroke()
    context.restoreGState()
    forms.append(path9)
    
    let path10 = UIBezierPath()
    path10.move(to: CGPoint(x: 0, y: 23.62))
    path10.addCurve(to: CGPoint(x: 30.69, y: 4.98), controlPoint1: CGPoint(x: 7.39, y: -2.98), controlPoint2: CGPoint(x: 5.19, y: 6.07))
    path10.addCurve(to: CGPoint(x: 60.28, y: 1.36), controlPoint1: CGPoint(x: 40.62, y: 4.56), controlPoint2: CGPoint(x: 50.37, y: 2.14))
    path10.addCurve(to: CGPoint(x: 71.65, y: 1.72), controlPoint1: CGPoint(x: 64.06, y: 1.05), controlPoint2: CGPoint(x: 70.12, y: -1.75))
    path10.addCurve(to: CGPoint(x: 64.52, y: 10.97), controlPoint1: CGPoint(x: 73.22, y: 5.28), controlPoint2: CGPoint(x: 66.3, y: 7.51))
    path10.addCurve(to: CGPoint(x: 61.53, y: 21.36), controlPoint1: CGPoint(x: 62.87, y: 14.18), controlPoint2: CGPoint(x: 62.53, y: 17.9))
    context.saveGState()
    context.translateBy(x: 105.29, y: 220.91)
    path10.lineWidth = 3
    UIColor.black.setStroke()
    path10.stroke()
    context.restoreGState()
    forms.append(path10)
    
    let path11 = UIBezierPath()
    path11.move(to: CGPoint(x: 0, y: 3.73))
    path11.addCurve(to: CGPoint(x: 187.26, y: 5.73), controlPoint1: CGPoint(x: 160.48, y: 1.08), controlPoint2: CGPoint(x: 98.27, y: -4.05))
    context.saveGState()
    context.translateBy(x: 50.02, y: 202.46)
    path11.lineWidth = 3
    UIColor.black.setStroke()
    path11.stroke()
    context.restoreGState()
    forms.append(path11)
    
    let path12 = UIBezierPath()
    path12.move(to: CGPoint(x: 12.99, y: 0))
    path12.addCurve(to: CGPoint(x: 0, y: 32.61), controlPoint1: CGPoint(x: 12.09, y: 14.74), controlPoint2: CGPoint(x: 13.33, y: 3.1))
    context.saveGState()
    context.translateBy(x: 78.18, y: 171.82)
    path12.lineWidth = 3
    UIColor.black.setStroke()
    path12.stroke()
    context.restoreGState()
    forms.append(path12)
    
    let path13 = UIBezierPath()
    path13.move(to: CGPoint(x: 9.45, y: 0))
    path13.addCurve(to: CGPoint(x: 0, y: 30.8), controlPoint1: CGPoint(x: 6.72, y: 19.31), controlPoint2: CGPoint(x: 9.33, y: 8.9))
    context.saveGState()
    context.translateBy(x: 104.37, y: 172.14)
    path13.lineWidth = 3
    UIColor.black.setStroke()
    path13.stroke()
    context.restoreGState()
    forms.append(path13)
    
    let path14 = UIBezierPath()
    path14.move(to: CGPoint(x: 6.6, y: 0))
    path14.addCurve(to: CGPoint(x: 0, y: 32.62), controlPoint1: CGPoint(x: 5.41, y: 17.92), controlPoint2: CGPoint(x: 6.79, y: 6.92))
    context.saveGState()
    context.translateBy(x: 132.84, y: 172)
    path14.lineWidth = 3
    UIColor.black.setStroke()
    path14.stroke()
    context.restoreGState()
    forms.append(path14)
    
    let path15 = UIBezierPath()
    path15.move(to: CGPoint(x: 3.81, y: 0))
    path15.addCurve(to: CGPoint(x: 0, y: 33.26), controlPoint1: CGPoint(x: 3.81, y: 18.22), controlPoint2: CGPoint(x: 4.39, y: 7.08))
    context.saveGState()
    context.translateBy(x: 159.23, y: 172.83)
    path15.lineWidth = 3
    UIColor.black.setStroke()
    path15.stroke()
    context.restoreGState()
    forms.append(path15)
    
    let path16 = UIBezierPath()
    path16.move(to: CGPoint(x: 4.1, y: 0))
    path16.addCurve(to: CGPoint(x: 0, y: 27.51), controlPoint1: CGPoint(x: 4.1, y: 13.86), controlPoint2: CGPoint(x: 4.55, y: 4.6))
    context.saveGState()
    context.translateBy(x: 183.69, y: 174.62)
    path16.lineWidth = 3
    UIColor.black.setStroke()
    path16.stroke()
    context.restoreGState()
    forms.append(path16)
    
    let path17 = UIBezierPath()
    path17.move(to: CGPoint(x: 4.75, y: 0))
    path17.addCurve(to: CGPoint(x: 0, y: 27.9), controlPoint1: CGPoint(x: 4.35, y: 15.33), controlPoint2: CGPoint(x: 5.2, y: 5.94))
    context.saveGState()
    context.translateBy(x: 206.95, y: 175.37)
    path17.lineWidth = 3
    UIColor.black.setStroke()
    path17.stroke()
    context.restoreGState()
    forms.append(path17)
    
    let path18 = UIBezierPath()
    path18.move(to: CGPoint(x: 7.94, y: 0))
    path18.addCurve(to: CGPoint(x: 0, y: 31.35), controlPoint1: CGPoint(x: 7.94, y: 14.44), controlPoint2: CGPoint(x: 8.47, y: 3.67))
    context.saveGState()
    context.translateBy(x: 227.41, y: 173.7)
    path18.lineWidth = 3
    UIColor.black.setStroke()
    path18.stroke()
    context.restoreGState()
    forms.append(path18)
    
    let path19 = UIBezierPath()
    path19.move(to: CGPoint(x: 2.13, y: 0))
    path19.addCurve(to: CGPoint(x: 2.72, y: 78.93), controlPoint1: CGPoint(x: 1.52, y: 74.55), controlPoint2: CGPoint(x: -2.68, y: 48.58))
    context.saveGState()
    context.translateBy(x: 81.52, y: 74.63)
    path19.lineWidth = 3
    UIColor.black.setStroke()
    path19.stroke()
    context.restoreGState()
    forms.append(path19)
    
    let path20 = UIBezierPath()
    path20.move(to: CGPoint.zero)
    path20.addCurve(to: CGPoint(x: 70.49, y: 7.29), controlPoint1: CGPoint(x: 23.65, y: 0), controlPoint2: CGPoint(x: 46.96, y: 6.35))
    path20.addCurve(to: CGPoint(x: 155.74, y: 3.38), controlPoint1: CGPoint(x: 120.85, y: 9.31), controlPoint2: CGPoint(x: 117.33, y: 8.58))
    context.saveGState()
    context.translateBy(x: 84.24, y: 153.56)
    path20.lineWidth = 3
    UIColor.black.setStroke()
    path20.stroke()
    context.restoreGState()
    forms.append(path20)
    
    let path21 = UIBezierPath()
    path21.move(to: CGPoint(x: 0, y: 1.11))
    path21.addCurve(to: CGPoint(x: 151.71, y: 0), controlPoint1: CGPoint(x: 50.57, y: 0.74), controlPoint2: CGPoint(x: 101.14, y: 0.37))
    context.saveGState()
    context.translateBy(x: 86.62, y: 72.36)
    path21.lineWidth = 3
    UIColor.black.setStroke()
    path21.stroke()
    context.restoreGState()
    forms.append(path21)
    
    let path22 = UIBezierPath()
    path22.move(to: CGPoint(x: 0.47, y: 0))
    path22.addLine(to: CGPoint(x: 0, y: 82.29))
    context.saveGState()
    context.translateBy(x: 239.94, y: 72.06)
    path22.lineWidth = 3
    UIColor.black.setStroke()
    path22.stroke()
    context.restoreGState()
    forms.append(path22)
    
    let path23 = UIBezierPath()
    path23.move(to: CGPoint(x: 0, y: 1.75))
    path23.addCurve(to: CGPoint(x: 83.01, y: 8.02), controlPoint1: CGPoint(x: 27.82, y: 1.75), controlPoint2: CGPoint(x: 55.19, y: 10.08))
    path23.addCurve(to: CGPoint(x: 184.37, y: 0.3), controlPoint1: CGPoint(x: 120.66, y: 5.24), controlPoint2: CGPoint(x: 149.16, y: -1.48))
    path23.addCurve(to: CGPoint(x: 187.15, y: 1.65), controlPoint1: CGPoint(x: 185.4, y: 0.35), controlPoint2: CGPoint(x: 186.22, y: 1.2))
    context.saveGState()
    context.translateBy(x: 59.96, y: 184.22)
    path23.lineWidth = 3
    UIColor.black.setStroke()
    path23.stroke()
    forms.append(path23)
    
    return forms
}
}
