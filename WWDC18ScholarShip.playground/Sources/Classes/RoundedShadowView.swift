import Foundation
import UIKit

class RoundedShadowView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.75
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = false
    }
    
}
