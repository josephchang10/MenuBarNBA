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
    
    init(s: Int, ta: String) {
        self.s = s
        self.ta = ta
    }
    
    convenience init(json: JSON) {
        let s = json["s"].int ?? 0
        let ta = json["ta"].string ?? ""
        self.init(s: s, ta: ta)
    }
}
