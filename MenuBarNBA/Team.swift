//
//  Team.swift
//  MenuBarNBA
//
//  Created by 张嘉夫 on 16/12/30.
//  Copyright © 2016年 张嘉夫. All rights reserved.
//

import SwiftyJSON

class Team {
    var s: Int
    let ta: String
    var playersStats = [PlayerStats]()
    
    init(s: Int, ta: String) {
        self.s = s
        self.ta = ta
    }
    
    convenience init(json: JSON) {
        let s = json["s"].int ?? 0
        let ta = json["ta"].string ?? ""
        self.init(s: s, ta: ta)
    }
    
    func setPlayerStats(json: JSON) {
        let pstsg = json["pstsg"]
        var tempPlayerStats = [PlayerStats]()
        for (_, dic) in pstsg {
            let playerStats = PlayerStats(firstName: dic["fn"].string, lastName: dic["ln"].string, position: dic["pos"].string, minute: dic["min"].int, second: dic["sec"].int, fieldGoalMade: dic["fgm"].int, fieldGoalAttempted: dic["fga"].int, fieldGoal3Made: dic["tpa"].int, fieldGoal3Attempted: dic["tpm"].int, freeThrowMade: dic["ftm"].int, freeThrowAttempted: dic["fta"].int, offensiveRebound: dic["oreb"].int, defensiveRebound: dic["dreb"].int, rebound: dic["reb"].int, assist: dic["ast"].int, steal: dic["stl"].int, block: dic["blk"].int, turnover: dic["tov"].int, points: dic["pts"].int, foul: dic["pf"].int, plus_minus: dic["pm"].int)
            tempPlayerStats.append(playerStats)
        }
        self.playersStats = tempPlayerStats
    }
}
