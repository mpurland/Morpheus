//
//  GameCell.swift
//  Morpheus
//
//  Created by Matthew Purland on 12/11/15.
//  Copyright © 2015 Matthew Purland. All rights reserved.
//

import Foundation
import Morpheus
import ReactiveCocoa
import ReactiveBind

class GameCell: Cell {
    let viewModelProperty = MutableProperty<GameCellViewModel?>(nil)
    
    var viewModel: GameCellViewModel? {
        get {
            return viewModelProperty.value
        }
        set {
            viewModelProperty.value = newValue
        }
    }
    
    override func prepareCell() {
        textLabel?.rac_text <~ viewModelProperty.producer.map { $0?.title ?? "" }
        detailTextLabel?.rac_text <~ viewModelProperty.producer.map { $0?.subtitle ?? "" }
    }
}