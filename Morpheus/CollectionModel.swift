import Foundation
import ReactiveCocoa

public class CollectionModel<T> {
    public typealias Model = [T]
    
    let modelProperty = MutableProperty<Model>([])
    
    public var model: AnyProperty<Model> {
        get {
            return AnyProperty<Model>(modelProperty)
        }
        set {
            modelProperty.value = newValue.value
        }
    }
    
    public init(producer: SignalProducer<Model, NoError>) {
        modelProperty <~ producer
    }
}

extension CollectionModel: UpdateableModel {
    public var updated: SignalProducer<Void, NoError> {
        return modelProperty.producer.map { _ in }
    }
}
