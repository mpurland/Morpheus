//
//  CellType.swift
//  Morpheus
//
//  Created by Matthew Purland on 12/11/15.
//  Copyright © 2015 Matthew Purland. All rights reserved.
//

import UIKit

public protocol CellType: ReuseableType, ConfigurerType {
}

extension UITableViewCell: CellType {
    public typealias T = CellRowConfigurer
    public func configure(type: T) {
        type.configure(self)
    }
}
