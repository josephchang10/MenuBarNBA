//
//  BoxScoreViewController.swift
//  MenuBarNBA
//
//  Created by 张嘉夫 on 16/12/30.
//  Copyright © 2016年 张嘉夫. All rights reserved.
//

import Cocoa

class BoxScoreViewController: NSViewController {

    @IBOutlet weak var visitingRadio: NSButton!
    @IBOutlet weak var homeRadio: NSButton!
    @IBOutlet weak var tableView: NSTableView!
    var game: Game?
    var team: Team? {
        get {
            if homeRadio.state == NSOnState {
                return game?.h
            }else {
                return game?.v
            }
        }
    }
    @IBOutlet weak var placeTextField: NSTextField!
    @IBOutlet weak var atTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        guard let game = game else {
            return
        }
        homeRadio.title = NSLocalizedString(game.h.ta, comment: "球队名字")
        visitingRadio.title = NSLocalizedString(game.v.ta, comment: "客场名字")
        DataLoader.shared.loadBoxScore(game: game) {
            print(game.h.playersStats.count)
            self.placeTextField.stringValue = "\(game.ac ?? "")@\(game.an ?? "")"
            self.atTextField.stringValue = NSLocalizedString("BoxScoreAt", comment: "上座") + "：\(game.at ?? 0)"
            self.tableView.reloadData()
        }
    }
    
    @IBAction func teamRadioChanged(_ sender: NSButton) {
        tableView.reloadData()
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(sender)
    }
    
    
}

extension BoxScoreViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return team?.playersStats.count ?? 0
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        var text: String?
        
        if tableColumn == tableView.tableColumns[0] {
            text = team?.playersStats[row].name
        }else if tableColumn == tableView.tableColumns[1] {
            text = "\(team?.playersStats[row].minute ?? 0)"
        }else if tableColumn == tableView.tableColumns[2] {
            text = "\(team?.playersStats[row].points ?? 0)"
        }else if tableColumn == tableView.tableColumns[3] {
            text = "\(team?.playersStats[row].rebound ?? 0)"
        }else if tableColumn == tableView.tableColumns[4] {
            text = "\(team?.playersStats[row].assist ?? 0)"
        }else if tableColumn == tableView.tableColumns[5] {
            text = "\(team?.playersStats[row].fieldGoalMade ?? 0)-\(team?.playersStats[row].fieldGoalAttempted ?? 0)"
        }else if tableColumn == tableView.tableColumns[6] {
            text = "\(team?.playersStats[row].fieldGoal3Made ?? 0)-\(team?.playersStats[row].fieldGoal3Attempted ?? 0)"
        }
        
        return text
        
    }
    
}
