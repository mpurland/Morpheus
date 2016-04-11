import UIKit
import ReactiveBind
import ReactiveCocoa
import Result

public protocol ViewModelable {
    typealias T: ViewModel
    
    var viewModel: MutableProperty<T> { get }
    
    func defaultViewModel() -> T
    func bindViewModel()
}

/// UIViewController extension for `ViewModelable`
extension ViewModelable where Self: UIViewController {
    public func bindViewModel() {
        viewModel.producer.startWithNext { viewModel in
            let presented = merge([self.viewDidAppearProducer.mapTrue(), self.viewWillDisappearProducer.mapFalse()])
            let active = merge([SignalProducer<Bool, NoError>(value: true), NSNotificationCenter.defaultCenter().rac_notifications(UIApplicationDidBecomeActiveNotification, object: nil).mapTrue(),  NSNotificationCenter.defaultCenter().rac_notifications(UIApplicationWillResignActiveNotification, object: nil).mapFalse()])
            viewModel.active <~ combineLatest(presented, active).and()
            viewModel.active.producer.startWithNext { active in
                print("active: \(active)")
            }
        }
    }
}

/// AnyObject extension for `ViewModelable`

/// Association keys
private enum ViewModelableAssocationKey: String {
    case ViewModel
}

private struct ViewModelableAssociationKeys {
    static var ViewModelProperty = ViewModelableAssocationKey.ViewModel.rawValue
}

extension ViewModelable where Self: AnyObject {
    public var viewModel: MutableProperty<T> {
        return lazyMutablePropertyDefaultValue(self, &ViewModelableAssociationKeys.ViewModelProperty, { self.defaultViewModel() })
    }
    
    public var viewModelProducer: SignalProducer<T, NoError> {
        return viewModel.producer
    }
}