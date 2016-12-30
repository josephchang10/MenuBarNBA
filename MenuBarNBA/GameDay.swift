//
//  GameDay.swift
//  MenuBarNBA
//
//  Created by 张嘉夫 on 16/12/30.
//  Copyright © 2016年 张嘉夫. All rights reserved.
//

import SwiftyJSON

class GameDay {
    
    let games: [Game]
    let gdte: String
    
    init(games: [Game], gdte: String) {
        self.games = games
        self.gdte = gdte
    }
    
    convenience init(json: JSON) {
        // made for loadToday:
        var games = [Game]()
        for (_,g) in json["gs"]["g"] {
            games.append(Game(json: g))
        }
        let gdte = json["gs"]["gdte"].string ?? ""
        self.init(games: games, gdte: gdte)
    }
    
}
