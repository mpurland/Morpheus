import UIKit
import ReactiveCocoa
import ReactiveBind

/// Items
public protocol ItemType: Hashable, Equatable {
    var UUID: String { get }
}

public extension ItemType {
    public var UUID: String {
        return NSUUID().UUIDString
    }
    
    public var hashValue: Int {
        return UUID.hashValue
    }
}

/// A model for a static item with preset data such as content view, selected, and highlighted.
public struct Item: ItemType, ReuseableType {
    
    public var reuseIdentifier: String {
        return UUID
    }
}

public func ==(lhs: Item, rhs: Item) -> Bool {
    return lhs.UUID == rhs.UUID
}

class ItemViewModel<Cell: UICollectionViewCell>: ViewModelOf<(Cell, Item)> {
    init(cell: Cell, item: Item) {
        super.init((cell, item))
        
        model.producer.startWithNext { cell, item in
            CellItemConfigurer(item: item).configure(cell)
        }
    }
}
