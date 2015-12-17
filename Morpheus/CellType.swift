import UIKit

public protocol CellType: ReuseableType, ConfigurerType {
}

extension UITableViewCell: CellType {
    public typealias Type = TableCellRowConfigurer
    public func configure(type: Type) {
        type.configure(self)
    }
}

extension UICollectionViewCell: CellType {
    public typealias Type = CellItemConfigurer
    public func configure(type: Type) {
        type.configure(self)
    }
}
