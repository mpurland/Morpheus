import UIKit

/// This is a clone of `UICollectionViewDataSource` without NSObjectProtocol.
/// This is to allow using `CollectionViewDataSource` from within a protocol extension.
/// All optional methods are implemented to return an optional. `CollectionViewDataSourceDelegate` will return default values.
public protocol CollectionViewDataSource {
    @available(iOS 6.0, *)
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    
    @available(iOS 6.0, *)
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    
    @available(iOS 6.0, *)
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    
    @available(iOS 6.0, *)
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
    
    @available(iOS 9.0, *)
    func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool

    @available(iOS 9.0, *)
    func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath)
}

extension CollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
    }
}

public class CollectionViewDataSourceDelegate: NSObject {
    let dataSource: CollectionViewDataSource

    public init(dataSource otherDataSource: CollectionViewDataSource) {
        dataSource = otherDataSource
    }
}

extension CollectionViewDataSourceDelegate: UICollectionViewDataSource {
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.collectionView(collectionView, numberOfItemsInSection: section)
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return dataSource.collectionView(collectionView, cellForItemAtIndexPath: indexPath)
    }
    
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return dataSource.numberOfSectionsInCollectionView(collectionView)
    }
    
    public func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        return dataSource.collectionView(collectionView, viewForSupplementaryElementOfKind: kind, atIndexPath: indexPath)
    }
    
    @available(iOS 9.0, *)
    public func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return dataSource.collectionView(collectionView, canMoveItemAtIndexPath: indexPath)
    }
    
    @available(iOS 9.0, *)
    public func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
       return dataSource.collectionView(collectionView, moveItemAtIndexPath: sourceIndexPath, toIndexPath: destinationIndexPath)
    }
}
