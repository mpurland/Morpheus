//
//  ApiManager.swift
//  Morpheus
//
//  Created by Matthew Purland on 12/11/15.
//  Copyright © 2015 Matthew Purland. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Tyro
import Swiftz

class ApiManager {
    let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    
    var loadAction: Action<Void, GameList?, NSError> {
        return Action { _ in
            let url = NSURL.init <^> NSBundle(forClass: ApiManager.self).pathForResource("gamelist.json", ofType: nil)
            // NSURL(string: "http://en.lichess.org/api/game?username=hiimgosu&rated&nb=100&with_opening=1&with_moves=1")!
            if let url = url {
                return self.session.rac_dataWithRequest(NSURLRequest(URL: url)).map { data, response in
                    let gameList: GameList? = JSONValue.decode(data)?.value()
                    return gameList
                }
            }
            else {
                return SignalProducer<GameList?, NSError>(error: NSError(domain: "", code: 400, userInfo: nil))
            }
        }
    }
}