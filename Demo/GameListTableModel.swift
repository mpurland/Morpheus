//
//  GameListTableModel.swift
//  Morpheus
//
//  Created by Matthew Purland on 12/11/15.
//  Copyright © 2015 Matthew Purland. All rights reserved.
//

import Foundation
import Morpheus
import ReactiveCocoa

class GameListTableModel: ListTableModel<Game> {
    let apiManager = ApiManager(source: .Remote)
    
    init() {
        super.init(producer: SignalProducer<[Game], NoError>.empty)
    }
    
    func load() {
        //        modelProperty <~
    }
}