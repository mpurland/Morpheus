import UIKit

public protocol CellType: ReuseableType, ConfigurerType {
}

extension UITableViewCell: CellType {
    public typealias Type = TableCellItemConfigurer
    public func configure(type: Type) {
        type.configure(self)
    }
}

extension UICollectionViewCell: CellType {
    public typealias Type = CollectionCellItemConfigurer
    public func configure(type: Type) {
        type.configure(self)
    }
}
