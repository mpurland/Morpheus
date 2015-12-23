import UIKit
import ReactiveCocoa
import ReactiveBind

/// A model for a static item with preset data such as content view, selected, and highlighted.
public struct Item {
}

extension Item: ItemType {}
extension Item: ReuseableType {}