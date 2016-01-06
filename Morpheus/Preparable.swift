import UIKit
import ReactiveCocoa

protocol Preparable {
    func prepare()
}

class PreparableView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit() {
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken) {
            self.prepare()
        }
    }
}

extension PreparableView: Preparable {
    func prepare() {}
}

extension Preparable where Self: UICollectionReusableView {
    var rac_prepareForReuse: SignalProducer<Void, NoError> {
        return rac_producerForSelector("prepareForReuse")
    }
}

class PreparableTableCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit() {
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken) {
            self.prepare()
        }
    }
}

extension PreparableTableCell: Preparable {
    func prepare() {}
}

class PreparableCollectionCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit() {
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken) {
            self.prepare()
        }
    }
}

extension PreparableCollectionCell: Preparable {
    func prepare() {}
}

class PreparableCollectionReusableView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit() {
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken) {
            self.prepare()
        }
    }
}

extension PreparableCollectionReusableView: Preparable {
    func prepare() {}
}