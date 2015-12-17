import UIKit

public class CollectionCellConfigurer<Model>: ModelConfigurerType {
    public typealias Type = UICollectionViewCell
    
    public let model: Model
    
    public init(model otherModel: Model) {
        model = otherModel
    }
    
    public func configure(type: Type) {
        // do nothing for now
    }
}

public class CellItemConfigurer: CollectionCellConfigurer<Item> {

    public init(item: Item) {
        super.init(model: item)
    }
    
    override public func configure(cell: Type) {
    }
}
