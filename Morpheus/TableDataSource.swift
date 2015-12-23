import UIKit
import ReactiveCocoa

//public protocol TableDataSource: TableViewDataSource {
//    var tableView: UITableView { get }
//}
//
//public class ListTableModelDataSource<Model> {
//    public typealias ReuseTransformer = Model -> ReuseIdentifier
//    public typealias CellConfigurerTransformer = Model -> TableCellConfigurer<Model>
//    
//    public let tableView: UITableView
//    public let tableModel: ListTableModel<Model>
//    public let reuseTransformer: ReuseTransformer
//    public let cellConfigurerTransformer: CellConfigurerTransformer
//    
//    init(tableView otherTableView: UITableView, tableModel otherTableModel: ListTableModel<Model>, reuseTransformer otherReuseTransformer: ReuseTransformer, cellConfigurerTransformer otherCellConfigurerTransformer: CellConfigurerTransformer) {
//        tableView = otherTableView
//        tableModel = otherTableModel
//        reuseTransformer = otherReuseTransformer
//        cellConfigurerTransformer = otherCellConfigurerTransformer
//    }
//}
//
//extension ListTableModelDataSource: TableDataSource {
//    private func itemForIndexPath(indexPath: NSIndexPath) -> Model? {
//        return tableModel.model.value[indexPath.row]
//    }
//    
//    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return tableModel.model.value.count
//    }
//    
//    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        if let item = itemForIndexPath(indexPath) {
//            let reuseIdentifier = reuseTransformer(item)
//            let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)
//            
//            cellConfigurerTransformer(item).configure(cell)
//            
//            return cell
//        }
//        
//        assert(false, "Item does not exist for row: \(indexPath.row)")
//        return UITableViewCell()
//    }
//}
