import UIKit
import ReactiveCocoa
import ReactiveBind

public class ViewModelController<VM: ViewModel>: UIViewController {
    private let otherDefaultViewModel: VM
    
    init(defaultViewModel: VM) {
        otherDefaultViewModel = defaultViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
    }
}

extension ViewModelController: ViewModelable {
    public func defaultViewModel() -> VM {
        return otherDefaultViewModel
    }
}
