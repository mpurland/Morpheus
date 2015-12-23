import UIKit
import ReactiveCocoa
import ReactiveBind

public protocol RowType: ItemType {}

/// A model for a static row with preset data such as text and textColor.
public struct Row: RowType {
    var font: UIFont?
    var text: String?
    var textColor: UIColor?
    var detailText: String?
    var detailTextColor: UIColor?
}

extension Row: ItemType {}
extension Row: ReuseableType {}

//class CellRowViewModel<Cell: UITableViewCell>: ViewModelOf<(Cell, Row)> {
//    init(cell: Cell, row: Row) {
//        super.init((cell, row))
//        
//        model.producer.startWithNext { cell, row in
//            TableCellRowConfigurer(row: row).configure(cell)
//        }
//    }
//}
