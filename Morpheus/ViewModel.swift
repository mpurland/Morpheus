import Foundation
import ReactiveCocoa
import ReactiveBind

private enum ViewModelAssociationKey: String {
    case Active
}

private struct ViewModelAssociationKeys {
    static var ActiveProperty = ViewModelAssociationKey.Active.rawValue
}

/// A view model.
public protocol ViewModel {    
    /// The `active` property determines if this view model is currently active or inactive.
    var active: MutableProperty<Bool> { get }
    
    /// The `didBecomeActiveProducer` is a signal producer that sends an event when the view model becomes active.
    var didBecomeActiveProducer: SignalProducer<Void, NoError> { get }

    /// The `didBecomeInactiveProducer` is a signal producer that sends an event when the view model becomes inactive.
    var didBecomeInactiveProducer: SignalProducer<Void, NoError> { get }
}

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

extension ViewModel where Self: AnyObject {
    public var active: MutableProperty<Bool> {
        return lazyMutablePropertyDefaultValue(self, &ViewModelAssociationKeys.ActiveProperty, { false })
    }
}

public protocol ModelableViewModel: ViewModel, Modelable {
}