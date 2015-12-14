//
//  Configurer.swift
//  Morpheus
//
//  Created by Matthew Purland on 12/11/15.
//  Copyright © 2015 Matthew Purland. All rights reserved.
//

import UIKit

/// Configuration
/// A configurable entity. This is mainly used for configuring a CellType instance.
//public protocol ConfigurableType {
//    typealias T: ConfigurerType
//
//    func configure(type: T)
//}

public protocol ConfigurerType {
    typealias Type
    
    func configure(type: Type)
}

public protocol CellConfigurerType: ConfigurerType {
    typealias Type = UITableViewCell
    typealias Model
    var model: Model { get }
}

public class CellConfigurer<Model>: CellConfigurerType {
    public typealias Type = UITableViewCell
    
    private let _model: Model
    
    public var model: Model {
        return _model
    }
    
    public init(model otherModel: Model) {
        _model = otherModel
    }
    
    public func configure(type: UITableViewCell) {
    }
}

public class CellRowConfigurer: CellConfigurer<Row> {
    public init(row: Row) {
        super.init(model: row)
    }
    
    override public func configure(cell: UITableViewCell) {
        cell.textLabel?.font = model.font
        cell.textLabel?.text = model.text
        cell.textLabel?.textColor = model.textColor
        cell.detailTextLabel?.text = model.detailText
        cell.detailTextLabel?.textColor = model.detailTextColor
    }
}