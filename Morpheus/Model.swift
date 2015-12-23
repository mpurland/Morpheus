import Foundation
import ReactiveCocoa

/// A modeable type is a type that contains a model.
public protocol Modelable {
    typealias Model
    var model: AnyProperty<Model> { get }
}

/// A container for Modelable.
public struct ModelableOf<Model>: Modelable {
    public let model: AnyProperty<Model>
    
    public init(_ otherModel: Model) {
        model = AnyProperty(ConstantProperty(otherModel))
    }
}