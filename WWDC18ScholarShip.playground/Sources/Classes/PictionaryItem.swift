import Foundation
import UIKit

public class PictionaryItem {
    let itemName: String!
    let itemPath: UIBezierPath!
    
    init(itemName: String, itemPath: UIBezierPath) {
        self.itemName = itemName
        self.itemPath = itemPath
    }
}
