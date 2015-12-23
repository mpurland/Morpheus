import Foundation
import ReactiveBind
import ReactiveCocoa

private enum ViewModelAssociationKey: String {
    case Active
}

private struct ViewModelAssociationKeys {
    static var ActiveProperty = ViewModelAssociationKey.Active.rawValue
}

extension ViewModel where Self: AnyObject {
    public var active: MutableProperty<Bool> {
        return lazyMutablePropertyDefaultValue(self, &ViewModelAssociationKeys.ActiveProperty, { false })
    }
}