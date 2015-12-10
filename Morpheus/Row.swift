import Foundation
import UIKit
import ReactiveCocoa

/// Rows
public protocol RowType: Hashable, Equatable {
    var UUID: String { get }
}

public extension RowType {
    var UUID: String {
        return NSUUID().UUIDString
    }
}

/// A model for a static row with preset data such as text and textColor.
public struct Row {
    var text: String?
    var textColor: UIColor?
    var detailText: String?
    var detailTextColor: UIColor?
}

extension Row: RowType {
    public var hashValue: Int {
        return UUID.hashValue
    }
}

public func ==(lhs: Row, rhs: Row) -> Bool {
    return lhs.UUID == rhs.UUID
}

/// Sections
public protocol SectionType {
    typealias Row: RowType
    var rows: [Row] { get }
}

/// Configuration
/// A configurable entity. This is mainly used for configuring a CellType instance.
public protocol ConfigurableType {
    typealias T: ConfigurerType
    
    func configure(type: T)
}

public protocol ConfigurerType {
    typealias Type
    
    func configure(type: Type)
}

public protocol CellConfigurerType: ConfigurerType {
    typealias Type = UITableViewCell
    typealias Model
    var model: Model { get }
}

public protocol CellType: ReuseableType, ConfigurableType {
}

public class CellConfigurer<Model>: CellConfigurerType {
    public typealias Type = UITableViewCell

    private let _model: Model
    
    public var model: Model {
        return _model
    }
    
    public init(model otherModel: Model) {
        _model = otherModel
    }
    
    public func configure(type: UITableViewCell) {
    }
}

//extension CellConfigurer: ConfigurerType {
//    typealias Type = UITableViewCell
//    
//    func configure(type: UITableViewCell) {
//    }
//}

//struct CellConfigurer<C: CellType, T> {
//}

//extension CellConfigurer: CellConfigurerType {
//    func configure(type: T) {
//        <#code#>
//    }
//}

//struct CellConfigurer: CellConfigurerType {
//    func configure(cell: UITableViewCell) {
//    }
//    
//    func configure(cell: UITableViewCell)(row: Row) {
//        CellRowConfigurer(row: row).configure(cell)
//    }
//}

public class CellRowConfigurer: CellConfigurer<Row> {
    public init(row: Row) {
        super.init(model: row)
    }
    
    override public func configure(cell: UITableViewCell) {
        cell.textLabel?.text = model.text
        cell.textLabel?.textColor = model.textColor
        cell.detailTextLabel?.text = model.detailText
        cell.detailTextLabel?.textColor = model.detailTextColor
    }
}


extension UITableViewCell: CellType {
    public typealias T = CellRowConfigurer
    public func configure(type: T) {
        type.configure(self)
    }
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