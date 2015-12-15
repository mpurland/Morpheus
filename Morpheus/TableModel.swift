import Foundation
import ReactiveCocoa

public protocol TableModel: Modelable {
    /// A signal that sends an event when the model has been updated.
    var updated: SignalProducer<Void, NoError> { get }
}

public class ListTableModel<T> {
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

extension ListTableModel: TableModel {
    public var updated: SignalProducer<Void, NoError> {
        return modelProperty.producer.map { _ in }
    }
}