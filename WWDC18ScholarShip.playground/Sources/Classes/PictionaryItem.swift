import Foundation
import UIKit

public class PictionaryItem {
    
    let itemName: String!
    let itemPath: [UIBezierPath]!
    
    init(itemName: String, itemPath: [UIBezierPath]) {
        self.itemName = itemName
        self.itemPath = itemPath
    }
}

var PictionaryItems = [PictionaryItem]()
let macbook = PictionaryItem(itemName: "Macbook", itemPath: Forms.MacbookForm())

public func addPictionaryItemsToArray() {
    PictionaryItems.append(macbook)
}
