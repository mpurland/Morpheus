public typealias ReuseIdentifier = String

public protocol ReuseableType {
    var reuseIdentifier: ReuseIdentifier { get }
}

extension ReuseableType {
    /// By default, use the class name as the reuse identifier
    public var reuseIdentifier: String {
        return NSStringFromClass(self.dynamicType as! AnyObject.Type) as String
    }
}
