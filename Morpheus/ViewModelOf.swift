import Foundation
import ReactiveCocoa

/// A container for `ViewModel` that contains a `Model`.
public class ViewModelOf<Model> {
    public let active = MutableProperty<Bool>(false)
    public let model: AnyProperty<Model>
    
    public init(_ otherModel: Model) {
        model = AnyProperty(ConstantProperty(otherModel))
    }
}

extension ViewModelOf: Modelable {}
extension ViewModelOf: ViewModel {}