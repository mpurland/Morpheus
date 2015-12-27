import UIKit

/// This is a clone of `UITableViewDataSource` without NSObjectProtocol.
/// This is to allow using `TableViewDataSource` from within a protocol extension.
/// All optional methods are implemented to return an optional. `TableViewDataSourceDelegate` will return default values.
public protocol TableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String?
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool?
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool?
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]?
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int?
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath)
}

extension TableViewDataSource {
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    
    public func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return nil
    }
    
    public func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool? {
        return nil
    }
    
    public func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool? {
        return nil
    }
    
    public func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return nil
    }
    
    public func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int? {
        return nil
    }
    
    public func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    public func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
    }
}

public class TableViewDataSourceDelegate: NSObject {
    let dataSource: TableViewDataSource
    public init(dataSource otherDataSource: TableViewDataSource) {
        dataSource = otherDataSource
    }
}

extension TableViewDataSourceDelegate: UITableViewDataSource {
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.tableView(tableView, numberOfRowsInSection: section)
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return dataSource.tableView(tableView, cellForRowAtIndexPath: indexPath)
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataSource.numberOfSectionsInTableView(tableView)
    }
    
    public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource.tableView(tableView, titleForHeaderInSection: section)
    }
    
    public func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return dataSource.tableView(tableView, titleForFooterInSection: section)
    }
    
    public func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return dataSource.tableView(tableView, canEditRowAtIndexPath: indexPath) ?? true
    }
    
    public func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return dataSource.tableView(tableView, canMoveRowAtIndexPath: indexPath) ?? true
    }
    
    public func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return dataSource.sectionIndexTitlesForTableView(tableView)
    }
    
    public func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return dataSource.tableView(tableView, sectionForSectionIndexTitle: title, atIndex: index) ?? 0
    }
    
    public func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        dataSource.tableView(tableView, commitEditingStyle: editingStyle, forRowAtIndexPath: indexPath)
    }
    
    public func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        dataSource.tableView(tableView, moveRowAtIndexPath: sourceIndexPath, toIndexPath: destinationIndexPath)
    }
}