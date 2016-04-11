import UIKit
import ReactiveCocoa
import Result

public protocol Preparable {
    func prepare()
}

public class PreparableView: UIView {
    private var onceToken: dispatch_once_t = 0
    
    public convenience init() {
        self.init(frame: CGRectZero)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit() {
        dispatch_once(&onceToken) {
            self.prepare()
        }
    }
}

extension PreparableView: Preparable {
    public func prepare() {}
}

public class PreparableTableCell: UITableViewCell {
    private var onceToken: dispatch_once_t = 0
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit() {
        dispatch_once(&onceToken) {
            self.prepare()
        }
    }
}

extension PreparableTableCell: Preparable {
    public func prepare() {}
}

extension PreparableTableCell {
    public var rac_prepareForReuse: SignalProducer<Void, NoError> {
        return rac_producerForSelector("prepareForReuse")
    }
}

extension Preparable where Self: UICollectionReusableView {
    public var rac_prepareForReuse: SignalProducer<Void, NoError> {
        return rac_producerForSelector("prepareForReuse")
    }
}

public class PreparableCollectionCell: UICollectionViewCell {
    private var onceToken: dispatch_once_t = 0
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit() {
        dispatch_once(&onceToken) {
            self.prepare()
        }
    }
}

extension PreparableCollectionCell: Preparable {
    public func prepare() {}
}

public class PreparableCollectionReusableView: UICollectionReusableView {
    private var onceToken: dispatch_once_t = 0
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit() {
        dispatch_once(&onceToken) {
            self.prepare()
        }
    }
}

extension PreparableCollectionReusableView: Preparable {
    public func prepare() {}
}

public class PreparableTableHeaderFooterView: UITableViewHeaderFooterView {
    private var onceToken: dispatch_once_t = 0
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit() {
        dispatch_once(&onceToken) {
            self.prepare()
        }
    }
}

extension Preparable where Self: UITableViewHeaderFooterView {
    public var rac_prepareForReuse: SignalProducer<Void, NoError> {
        return rac_producerForSelector("prepareForReuse")
    }
}

extension UITableViewHeaderFooterView: Preparable {
    public func prepare() {}
}
