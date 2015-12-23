import Foundation

public protocol ItemType: Hashable, Equatable {
    var UUID: String { get }
}

public extension ItemType {
    public var UUID: String {
        return NSUUID().UUIDString
    }
    
    public var hashValue: Int {
        return UUID.hashValue
    }
}

extension ReuseableType where Self: ItemType {
    public var reuseIdentifier: ReuseIdentifier {
        return UUID
    }
}

public func ==<A: ItemType>(lhs: A, rhs: A) -> Bool {
    return lhs.UUID == rhs.UUID
}