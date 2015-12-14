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

//extension Row: RowType {
//    public var hashValue: Int {
//        return UUID.hashValue
//    }
//}

public func ==(lhs: Row, rhs: Row) -> Bool {
    return lhs.UUID == rhs.UUID
}

//
//class CellRowViewModel<Cell: UITableViewCell>: ViewModelTypeOf<(Cell, Row)> {
//    init(cell: Cell, row: Row) {
//        super.init((cell, row))
//        
////        cell.textLabel!.rac_text <~ model.producer.map { $0.text }
////        cell.detailTextLabel!.rac_text <~ model.producer.map { $0.detailTextColor }
//        
//        model.producer.startWithNext { cell, row in
//            CellRowConfigurer(row: row).configure(cell)
//        }
//    }
//}