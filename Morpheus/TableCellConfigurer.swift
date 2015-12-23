import UIKit

public class TableCellConfigurer<Model>: ModelConfigurerType {
    public typealias Type = UITableViewCell
    
    public let model: Model
    
    public init(model otherModel: Model) {
        model = otherModel
    }
    
    public func configure(type: Type) {
        // do nothing for now
    }
}

public class TableCellItemConfigurer: TableCellConfigurer<Item> {
    
    public init(row: Item) {
        super.init(model: row)
    }
    
    override public func configure(cell: Type) {
        cell.textLabel?.font = model.font
        cell.textLabel?.text = model.text
        cell.textLabel?.textColor = model.textColor
        cell.detailTextLabel?.text = model.detailText
        cell.detailTextLabel?.textColor = model.detailTextColor
    }
}
