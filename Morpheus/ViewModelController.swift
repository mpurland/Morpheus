import Foundation
import ReactiveCocoa
import ReactiveBind

private enum ViewModelableAssocationKey: String {
    case ViewModel
}

private struct ViewModelableAssociationKeys {
    static var ViewModelProperty = ViewModelableAssocationKey.ViewModel.rawValue
}

public protocol ViewModelable {
    typealias T: ViewModelType
    
    var viewModel: MutableProperty<T> { get }
    
    func defaultViewModel() -> T
}

public protocol ViewModelBindable {
    func bindViewModel()
}

public protocol ViewModelableBindable: ViewModelable, ViewModelBindable {}

extension ViewModelableBindable where Self: AnyObject {
    public var viewModel: MutableProperty<T> {
        return lazyMutablePropertyDefaultValue(self, &ViewModelableAssociationKeys.ViewModelProperty, { self.defaultViewModel() })
    }
}

extension ViewModelableBindable where Self: UIViewController {
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

public class ViewModelableBindableController<ViewModel: ViewModelType>: UIViewController {
    private let otherDefaultViewModel: ViewModel
    
    init(defaultViewModel: ViewModel) {
        otherDefaultViewModel = defaultViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
    }
}

extension ViewModelableBindableController: ViewModelableBindable {
    public func defaultViewModel() -> ViewModel {
        return otherDefaultViewModel
    }
}
