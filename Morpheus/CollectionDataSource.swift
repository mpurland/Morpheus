import UIKit
import ReactiveCocoa

public protocol CollectionDataSource: CollectionViewDataSource {
    var collectionView: UICollectionView { get }
}

public class CollectionModelDataSource<Model> {
    public typealias ReuseTransformer = Model -> ReuseIdentifier
    public typealias CellConfigurerTransformer = Model -> CollectionCellConfigurer<Model>
    
    public let collectionView: UICollectionView
    public let collectionModel: CollectionModel<Model>
    public let reuseTransformer: ReuseTransformer
    public let cellConfigurerTransformer: CellConfigurerTransformer
    
    init(collectionView otherCollectionView: UICollectionView, collectionModel otherCollectionModel: CollectionModel<Model>, reuseTransformer otherReuseTransformer: ReuseTransformer, cellConfigurerTransformer otherCellConfigurerTransformer: CellConfigurerTransformer) {
        collectionView = otherCollectionView
        collectionModel = otherCollectionModel
        reuseTransformer = otherReuseTransformer
        cellConfigurerTransformer = otherCellConfigurerTransformer
    }
}
