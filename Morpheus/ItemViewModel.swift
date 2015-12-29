import Foundation

class ItemViewModel<Cell: UICollectionViewCell>: ViewModelOf<(Cell, Item)> {
    init(cell: Cell, item: Item) {
        super.init((cell, item))
        
        model.producer.startWithNext { cell, item in
            CollectionCellItemConfigurer(item: item).configure(cell)
        }
    }
}