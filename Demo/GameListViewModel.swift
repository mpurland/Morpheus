//
//  GameListViewModel.swift
//  Morpheus
//
//  Created by Matthew Purland on 12/11/15.
//  Copyright © 2015 Matthew Purland. All rights reserved.
//

import Foundation
import Morpheus
import ReactiveCocoa

struct GameListViewModel {
    let gameList = MutableProperty<GameList?>(nil)
    let apiManager = ApiManager(source: .Remote)
    
    init(gameList otherGameList: GameList?) {
        gameList.value = otherGameList
    }
    
    init() {
        self.init(gameList: nil)
    }
    
    var games: [Game] {
        return gameList.value?.games ?? []
    }
    
    var loading: SignalProducer<Bool, NoError> {
        return gameList.producer.map { $0 == nil }
    }
    
    var empty: SignalProducer<Bool, NoError> {
        return gameList.producer.map { $0?.games.count == 0 }
    }
    
    func load() {
        gameList <~ apiManager.loadAction.apply().suppressError().delay(2.0, onScheduler: QueueScheduler())
    }
}