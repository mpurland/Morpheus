import Foundation
import UIKit
import ReactiveCocoa
import ReactiveBind

/// Rows
public protocol RowType: Hashable, Equatable {
    var UUID: String { get }
}

public extension RowType {
    public var UUID: String {
        return NSUUID().UUIDString
    }
    
    public var hashValue: Int {
        return UUID.hashValue
    }
}

/// A model for a static row with preset data such as text and textColor.
public struct Row: RowType, ReuseableType {
    var font: UIFont?
    var text: String?
    var textColor: UIColor?
    var detailText: String?
    var detailTextColor: UIColor?
    
    public var reuseIdentifier: String {
        return UUID
    }
}

public func ==(lhs: Row, rhs: Row) -> Bool {
    return lhs.UUID == rhs.UUID
}

class CellRowViewModel<Cell: UITableViewCell>: ViewModelOf<(Cell, Row)> {
    init(cell: Cell, row: Row) {
        super.init((cell, row))
        
        model.producer.startWithNext { cell, row in
            CellRowConfigurer(row: row).configure(cell)
        }
    }
}