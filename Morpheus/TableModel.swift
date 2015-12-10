import Foundation
import ReactiveCocoa

public protocol TableModel: ModelableType {
    /// A signal that sends an event when the model has been updated.
    var updated: Signal<Void, NoError> { get }
}

public class ListTableModel<Model> {
    public typealias T = Model
    public typealias ModelType = [T]
    
    let modelProperty = MutableProperty<ModelType>([])
    private let (updatedSignal, updatedObserver) = Signal<Void, NoError>.pipe()
    
    public var model: ModelType {
        get {
            return modelProperty.value
        }
        set {
            modelProperty.value = newValue
        }
    }
    
//    convenience init(model: ModelType) {
//        self.init(modelProducer: SignalProducer<ModelType, NoError>(value: model))
//    }
    
    public init(producer: SignalProducer<ModelType, NoError>) {
        modelProperty <~ producer
    }
}

extension ListTableModel: TableModel {
    public var updated: Signal<Void, NoError> {
        return updatedSignal
    }
}