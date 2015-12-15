import Foundation
import ReactiveCocoa

public protocol TableModel: Modelable {
    /// A signal that sends an event when the model has been updated.
    var updated: SignalProducer<Void, NoError> { get }
}

public class ListTableModel<Model> {
    public typealias T = Model
    public typealias ModelType = [T]
    
    let modelProperty = MutableProperty<ModelType>([])
    
    public var model: AnyProperty<ModelType> {
        get {
            return AnyProperty<ModelType>(modelProperty)
        }
        set {
            modelProperty.value = newValue.value
        }
    }
    
    public init(producer: SignalProducer<ModelType, NoError>) {
        modelProperty <~ producer
    }
}

extension ListTableModel: TableModel {
    public var updated: SignalProducer<Void, NoError> {
        return modelProperty.producer.map { _ in }
    }
}