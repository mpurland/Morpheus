//
//  Game.swift
//  Morpheus
//
//  Created by Matthew Purland on 12/11/15.
//  Copyright © 2015 Matthew Purland. All rights reserved.
//

import Foundation
import Swiftz
import Tyro

struct Game {
    let whitePlayer: String
    let blackPlayer: String
    let moves: String
    let opening: String
}

extension Game: FromJSON {
    static func fromJSON(value: JSONValue) -> Either<JSONError, Game> {
        let whitePlayer: String? = value <? "players" <> "white" <> "userId"
        let blackPlayer: String? = value <? "players" <> "black" <> "userId"
        let moves: String? = value <? "moves"
        let opening: String? = value <? "opening" <> "name"
        
        return (curry(Game.init)
            <^> whitePlayer
            <*> blackPlayer
            <*> moves
            <*> opening).toEither(.Custom("Could not decode Game from json"))
    }
}