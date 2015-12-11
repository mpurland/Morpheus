import Foundation
import ReactiveCocoa

/// A runnable action is an `Action` that takes no input, output, and does not error.
typealias RunnableAction = Action<Void, Void, NoError>

extension ActionError {
    var error: Error? {
        switch self {
        case .ProducerError(let error): return error
        default: return nil
        }
    }
}

extension Action {
    /// Creates a RunnableAction from a given () -> () closure.
    class func action(closure: () -> ()) -> RunnableAction {
        return RunnableAction { _ in
            closure()
            return emptyProducer()
        }
    }
}

extension Action {
    /// Returns a SignalProducer that applies the Input of the given SignalProducer to the Action and returns the returned Output from the Action (through apply).
    func applyOn(producer: SignalProducer<Input, NoError>) -> SignalProducer<Output, NoError> {
        return producer.flatMap(.Latest, transform: { (input) -> SignalProducer<Output, NoError> in
            return self.apply(input).suppressError()
        })
    }
    
    /// Starts and applies SignalProducer that applies the Input of the given SignalProducer to the Action and returns the returned Output from the Action (through apply).
    func startApplyOn(producer: SignalProducer<Input, NoError>) -> Disposable {
        let disposable = CompositeDisposable()
        let applyOnProducer = applyOn(producer)
        
        disposable += applyOnProducer.startWithCompleted {
            disposable.dispose()
        }
        
        return disposable
    }
}

/// Bind the execution of the action with input from the sent value from the producer.
public func <~ <Input, Output>(action: Action<Input, Output, NoError>, producer: SignalProducer<Input, NoError>) -> Disposable {
    return action.startApplyOn(producer)
}