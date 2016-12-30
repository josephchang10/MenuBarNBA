//
//  DataLoader.swift
//  MenuBarNBA
//
//  Created by 张嘉夫 on 16/12/29.
//  Copyright © 2016年 张嘉夫. All rights reserved.
//

import Cocoa
import SwiftyJSON
import Alamofire

public class DataLoader {

    static let shared = DataLoader()
    
    func loadToday(completion: @escaping (_ gameDay: GameDay) -> Void) {
        Alamofire.request("https://data.nba.com/data/5s/v2015/json/mobile_teams/nba/2016/scores/00_todays_scores.json").responseJSON { (response) in
            
            guard let data = response.data else {
                print("数据加载失败")
                return
            }
            
            print("数据加载成功")
            
            let gameDay = GameDay(json: JSON(data: data))
            
            completion(gameDay)
        }
    }
    
    func loadBoxScore(game: Game, completion: @escaping () -> Void) {
        let urlString = "https://data.nba.com/data/10s/v2015/json/mobile_teams/nba/2016/scores/gamedetail/\(game.gid)_gamedetail.json"
        print("Box Score URL String: \(urlString)")
        Alamofire.request(urlString).responseJSON { (response) in
            
            guard let data = response.data else {
                print("Box Score 数据加载失败")
                return
            }
            
            let json = JSON(data: data)
            
//            print("Box Score 数据加载成功：\(json)")
            
            game.setStats(data: json)
            
            completion()
        }
    }
    
}
