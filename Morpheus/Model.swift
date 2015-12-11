import Foundation

/// A modeable type is a type that contains a model.
public protocol Modelable {
    typealias ModelType
    var model: ModelType { get }
}

/// A container for Modelable.
public struct ModelableOf<ModelType>: Modelable {
    public let model: ModelType
}