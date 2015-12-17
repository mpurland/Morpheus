import UIKit

/// A configurer type to configure specific types. This is mainly used for configuring a CellType instance.
public protocol ConfigurerType {
    typealias Type
    func configure(type: Type)
}

public protocol ModelConfigurerType: ConfigurerType {
    typealias Model
    var model: Model { get }
}
