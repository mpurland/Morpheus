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

enum ApiSource {
    case Local, Remote
    
    var url: NSURL? {
        switch self {
        case .Local: return NSURL.init <^> NSBundle(forClass: ApiManager.self).pathForResource("gamelist.json", ofType: nil)
        case .Remote: return NSURL(string: "http://en.lichess.org/api/game?username=hiimgosu&rated&nb=100&with_opening=1&with_moves=1")
        }
    }
}

class ApiManager {
    let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    
    let source: ApiSource
    
    init(source: ApiSource) {
        self.source = source
    }
    
    var loadAction: Action<Void, GameList?, NSError> {
        return Action { [weak self] _ in
            if let weakSelf = self, url = weakSelf.source.url {
                return weakSelf.session.rac_dataWithRequest(NSURLRequest(URL: url)).map { data, response in
                    let gameList: GameList? = JSONValue.decode(data)?.value()
                    return gameList
                }.observeOn(QueueScheduler())
            }
            else {
                return SignalProducer<GameList?, NSError>(error: NSError(domain: "", code: 400, userInfo: nil))
            }
        }
    }
}