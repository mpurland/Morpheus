import Foundation
import ReactiveCocoa

/// A view model. The `active` property determines if this view model is currently active or inactive.
public protocol ViewModelType {
    var active: MutableProperty<Bool> { get }
    
    var didBecomeActiveProducer: SignalProducer<Void, NoError> { get }
    
    var didBecomeInactiveProducer: SignalProducer<Void, NoError> { get }
}

extension ViewModelType {
    public var didBecomeActiveProducer: SignalProducer<Void, NoError> {
        return active.producer.skipRepeats().filter(true).map { value -> Bool in
            print("active = \(value)")
            return value
        }.map { _ in SignalProducer<Void, NoError>.empty }
    }
    
    public var didBecomeInactiveProducer: SignalProducer<Void, NoError> {
        return active.producer.skipRepeats().filter(false).map { value -> Bool in
            print("active = \(value)")
            return value
        }.map { _ in SignalProducer<Void, NoError>.empty }
    }
}

public class ViewModelTypeOf<Model> {
    public let active = MutableProperty<Bool>(false)
    public let model: ConstantProperty<Model>
    
    public init(_ otherModel: Model) {
        model = ConstantProperty(otherModel)
    }
}

extension ViewModelTypeOf: ViewModelType {}