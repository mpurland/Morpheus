import Foundation
import ReactiveCocoa
import ReactiveBind

/// A view model.
public protocol ViewModel {    
    /// The `active` property determines if this view model is currently active or inactive.
    var active: MutableProperty<Bool> { get }
    
    /// The `didBecomeActiveProducer` is a signal producer that sends an event when the view model becomes active.
    var didBecomeActiveProducer: SignalProducer<Void, NoError> { get }

    /// The `didBecomeInactiveProducer` is a signal producer that sends an event when the view model becomes inactive.
    var didBecomeInactiveProducer: SignalProducer<Void, NoError> { get }
}

/// Extension to `ViewModel` to allow didBecomeActiveProducer and didBecomeInactiveProducer to be based on active property.
extension ViewModel {
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

/// AnyObject extension for `ViewModel`

/// Association keys
private enum ViewModelAssociationKey: String {
    case Active
}

private struct ViewModelAssociationKeys {
    static var ActiveProperty = ViewModelAssociationKey.Active.rawValue
}

/// Extension to `ViewModel` that are of type AnyObject to implement a default active property.
extension ViewModel where Self: AnyObject {
    public var active: MutableProperty<Bool> {
        return lazyMutablePropertyDefaultValue(self, &ViewModelAssociationKeys.ActiveProperty, { false })
    }
}