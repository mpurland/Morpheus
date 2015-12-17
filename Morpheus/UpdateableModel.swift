import UIKit
import ReactiveCocoa

public protocol UpdateableModel: Modelable {
    /// A signal that sends an event when the model has been updated.
    var updated: SignalProducer<Void, NoError> { get }
}
