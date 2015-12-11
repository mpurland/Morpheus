//
//  GameList.swift
//  Morpheus
//
//  Created by Matthew Purland on 12/11/15.
//  Copyright © 2015 Matthew Purland. All rights reserved.
//

import Foundation
import Tyro
import Swiftz

struct GameList {
    let games: [Game]
}

extension GameList: FromJSON {
    static func fromJSON(value: JSONValue) -> Either<JSONError, GameList> {
        let games: [Game]? = value <? "list"
        return (GameList.init <^> games).toEither(.Custom("Could not decode GameList from json"))
        
    }
}