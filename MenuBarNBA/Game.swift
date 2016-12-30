//
//  Game.swift
//  MenuBarNBA
//
//  Created by 张嘉夫 on 16/12/30.
//  Copyright © 2016年 张嘉夫. All rights reserved.
//

import SwiftyJSON

class Game {
    var cl: String
    var stt: String
    let gid: String
    let v: Team
    let h: Team
    var an: String?
    var ac: String?
    var at: Int?
    
    init(cl: String, gid: String, v: Team, h:Team, stt: String) {
        self.cl = cl
        self.gid = gid
        self.v = v
        self.h = h
        self.stt = stt
    }
    
    convenience init(json: JSON) {
        let cl = json["cl"].string ?? ""
        let gid = json["gid"].string ?? ""
        let stt = json["stt"].string ?? ""
        let v = json["v"]
        let h = json["h"]
        let vTeam = Team(json: v)
        let hTeam = Team(json: h)
        
        self.init(cl: cl, gid: gid, v: vTeam, h: hTeam, stt: stt)
    }
    
    func setStats(data: JSON) {
        let json = data["g"]
        an = json["an"].string
        ac = json["ac"].string
        at = json["at"].int
        
        h.setPlayerStats(json: json["hls"])
        v.setPlayerStats(json: json["vls"])
    }
}
