import UIKit
import ReactiveCocoa
import ReactiveBind

/// A model for a static item with preset data.
public struct Item {
    var font: UIFont?
    var text: String?
    var textColor: UIColor?
    var detailText: String?
    var detailTextColor: UIColor?
}

extension Item: ItemType {}
extension Item: ReuseableType {}