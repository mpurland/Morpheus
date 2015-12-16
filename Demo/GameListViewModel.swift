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

class GameListViewModel {
    let gameList = MutableProperty<GameList?>(nil)
    let apiManager = ApiManager(source: .Remote)
    
    init(gameList: GameList?) {
        self.gameList.value = gameList
        bindActions()
    }
    
    convenience init() {
        self.init(gameList: nil)
    }
    
    func bindActions() {
        gameList <~ didBecomeActiveProducer.take(1).then(load)
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
    
    lazy var load: SignalProducer<GameList?, NoError> = {
        return self.apiManager.loadAction.apply().suppressError().delay(1.0, onScheduler: QueueScheduler())
    }()
}

extension GameListViewModel: ViewModel {}

extension GameListViewModel: Modelable {
    typealias Model = GameList?
    var model: AnyProperty<Model> {
        return AnyProperty<Model>(gameList)
    }
}