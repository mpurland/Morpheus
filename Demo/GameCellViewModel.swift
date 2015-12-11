//
//  GameCellViewModel.swift
//  Morpheus
//
//  Created by Matthew Purland on 12/11/15.
//  Copyright © 2015 Matthew Purland. All rights reserved.
//

import Foundation

struct GameCellViewModel {
    private let game: Game
    
    var title: String {
        return "\(game.whitePlayer) - \(game.blackPlayer)"
    }
    
    var subtitle: String {
        return "\(game.opening): \(game.moves)"
    }
    
    init(game otherGame: Game) {
        game = otherGame
    }
}