import ReactiveCocoa
import ReactiveBind
import Result

extension SignalProducerType {
    public func mapReplace<V>(@autoclosure(escaping) closure: () -> V) -> SignalProducer<V, Error> {
        return map { _ in closure() }
    }
    
    public func mapTrue() -> SignalProducer<Bool, Error> {
        return mapReplace(true)
    }
    
    public func mapFalse() -> SignalProducer<Bool, Error> {
        return mapReplace(false)
    }
    
    public func mapEmpty() -> SignalProducer<Void, Error> {
        return map { _ in SignalProducer<Void, Error>.empty }
    }
}

extension SignalProducerType where Value: Equatable {
    public func filter(value: Value) -> SignalProducer<Value, Error> {
        return filter { $0 == value }
    }
}

extension SignalProducerType where Value == Bool {
    public func not() -> SignalProducer<Value, Error> {
        return map { !$0 }
    }
}

extension SignalProducerType where Value == (Bool, Bool) {
    public func and() -> SignalProducer<Bool, Error> {
        return map { $0 && $1 }
    }
    public func or() -> SignalProducer<Bool, Error> {
        return map { $0 || $1 }
    }
}

extension SignalProducerType where Value == (Bool, Bool, Bool) {
    public func and() -> SignalProducer<Bool, Error> {
        return map { $0 && $1 && $2 }
    }
    public func or() -> SignalProducer<Bool, Error> {
        return map { $0 || $1 || $2 }
    }
}

extension SignalProducerType where Value == (Bool, Bool, Bool, Bool) {
    public func and() -> SignalProducer<Bool, Error> {
        return map { $0 && $1 && $2 && $3 }
    }
    public func or() -> SignalProducer<Bool, Error> {
        return map { $0 || $1 || $2 || $3 }
    }
}

extension SignalProducerType where Value == (Bool, Bool, Bool, Bool, Bool) {
    public func and() -> SignalProducer<Bool, Error> {
        return map { $0 && $1 && $2 && $3 && $4 }
    }
    public func or() -> SignalProducer<Bool, Error> {
        return map { $0 || $1 || $2 || $3 || $4 }
    }
}

extension RACSignal {
    public func toVoidSignalProducer() -> SignalProducer<Void, NSError> {
        return toSignalProducer().mapEmpty()
    }
}

/// Merge signals into a single signal producer
public func merge<T, E: ErrorType>(signals: [SignalProducer<T, E>]) -> SignalProducer<T, E> {
    return SignalProducer<SignalProducer<T, E>, E>(values: signals).flatten(FlattenStrategy.Merge)
}

extension NSObject {
    public func rac_producerForSelector(selector: Selector) -> SignalProducer<Void, NoError> {
        return rac_signalForSelector(selector).toVoidSignalProducer().suppressError()
    }
}

extension UIViewController {
    public var viewDidLoadProducer: SignalProducer<Void, NoError> {
        return rac_producerForSelector("viewDidLoad")
    }
    public var viewWillAppearProducer: SignalProducer<Void, NoError> {
        return rac_producerForSelector("viewWillAppear:")
    }
    public var viewDidAppearProducer: SignalProducer<Void, NoError> {
        return rac_producerForSelector("viewDidAppear:")
    }
    public var viewWillDisappearProducer: SignalProducer<Void, NoError> {
        return rac_producerForSelector("viewWillDisappear:")
    }
    public var viewDidDisappearProducer: SignalProducer<Void, NoError> {
        return rac_producerForSelector("viewDidDisappear:")
    }
}