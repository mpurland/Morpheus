import Foundation
import ReactiveCocoa

public typealias RunnableAction = Action<Void, Void, NoError>
//typealias RunnableActionResult = SignalProducer<Void, NoError>

extension Action {
    public class func action(closure: () -> ()) -> Action<Void, Void, NoError> {
        return RunnableAction { _ in
            closure()
            return SignalProducer<Void, NoError>.empty
        }
    }
}

extension Action {
    public func applyOn(producer: SignalProducer<Input, NoError>) -> SignalProducer<Output, NoError> {
        return producer.flatMap(.Latest, transform: { (input) -> SignalProducer<Output, NoError> in
            return self.apply(input).suppressError()
        })
    }
    
    private func applyOnDisposable(producer: SignalProducer<Input, NoError>) -> Disposable {
        let disposable = CompositeDisposable()
        let applyOnProducer = applyOn(producer)
        
        disposable += applyOnProducer.startWithCompleted {
            disposable.dispose()
        }
        
        return disposable
    }
}

public func <~ <A: Action<Void, Void, NoError>>(action: A, producer: SignalProducer<Void, NoError>) -> Disposable {
    return action.applyOnDisposable(producer)
}

public func <~ <A: Action<Bool, Void, NoError>>(action: A, producer: SignalProducer<Bool, NoError>) -> Disposable {
    return action.applyOnDisposable(producer)
}

public func <~ <A: Action<String, Void, NoError>>(action: A, producer: SignalProducer<String, NoError>) -> Disposable {
    return action.applyOnDisposable(producer)
}

//public func <~ <T, A: Action<T, Void, NoError>>(action: A, producer: SignalProducer<T, NoError>) -> Disposable {
//    let disposable = CompositeDisposable()
////    let applyOnProducer = action.applyOn(producer)
//    let newProducer: SignalProducer<T, NoError> = producer.flatMap(.Latest, transform: { (input) -> SignalProducer<T, NoError> in
//        return SignalProducer<T, NoError>.empty
//    })
//    let applyOnProducer = action.applyOn(newProducer)
//    
//    disposable += applyOnProducer.startWithCompleted {
//        disposable.dispose()
//    }
//    
//    return disposable
//}