//
//  Player.swift
//  MenuBarNBA
//
//  Created by 张嘉夫 on 16/12/30.
//  Copyright © 2016年 张嘉夫. All rights reserved.
//

struct PlayerStats {
    let firstName: String?
    let lastName: String?
    let position: String?
    var minute: Int?
    var second: Int?
    var fieldGoalMade: Int?
    var fieldGoalAttempted: Int?
    var fieldGoal3Made: Int?
    var fieldGoal3Attempted: Int?
    var freeThrowMade: Int?
    var freeThrowAttempted: Int?
    var offensiveRebound: Int?
    var defensiveRebound: Int?
    var rebound: Int?
    var assist: Int?
    var steal: Int?
    var block: Int?
    var turnover: Int?
    var points: Int?
    var foul: Int?
    var plus_minus: Int?
    
    var name: String {
        get {
            return (firstName ?? "") + " " + (lastName ?? "")
        }
    }
    
    var fieldGoalPercent: Double? {
        get {
            guard let fieldGoalAttempted = fieldGoalAttempted else {
                return 0
            }
            return Double(fieldGoalMade ?? 0)/Double(fieldGoalAttempted)
        }
    }
}
