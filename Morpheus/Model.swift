import Foundation
import ReactiveCocoa

/// A modelable type is a type that contains a model.
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

extension Modelable {
    /// A producer that sends an event when the model has been updated.
    var updated: SignalProducer<Void, NoError> {
        return model.producer.map { _ in }
    }
}