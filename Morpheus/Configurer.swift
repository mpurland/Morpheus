import UIKit

/// A configurer type to configure specific types. This is mainly used for configuring a CellType instance.
public protocol ConfigurerType {
    associatedtype Type
    func configure(type: Type)
}

public protocol ModelConfigurerType: ConfigurerType {
    associatedtype Model
    var model: Model { get }
}
