import Foundation

public protocol Modelable {
    typealias ModelType
    var model: ModelType { get }
}

public struct ModelableOf<ModelType>: Modelable {
    public let model: ModelType
}