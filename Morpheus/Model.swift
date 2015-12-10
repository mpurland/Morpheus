import Foundation

/// Is ModelType needed? Can a model be reprsented contextually in types with generics and a model property?
public protocol ModelType {
    
}

public protocol ModelableType {
    typealias ModelType
    var model: ModelType { get }
}

public struct Modelable<ModelType>: ModelableType {
    public let model: ModelType
}