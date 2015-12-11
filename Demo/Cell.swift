//
//  Cell.swift
//  Morpheus
//
//  Created by Matthew Purland on 12/11/15.
//  Copyright © 2015 Matthew Purland. All rights reserved.
//

import Foundation
import UIKit

class Cell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Subtitle, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken) {
            self.prepareCell()
        }
    }
}

extension Cell: PreparableCell {
    func prepareCell() {
    }
}