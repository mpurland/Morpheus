import Foundation
import ReactiveCocoa

/// Container for ViewModel.
public class ViewModelOf<Model> {
    public let active = MutableProperty<Bool>(false)
    public let model: ConstantProperty<Model>
    
    public init(_ otherModel: Model) {
        model = ConstantProperty(otherModel)
    }
}

extension ViewModelOf: ViewModel {}