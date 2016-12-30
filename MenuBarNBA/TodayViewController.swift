//
//  TodayViewController.swift
//  MenuBarNBA
//
//  Created by 张嘉夫 on 16/12/29.
//  Copyright © 2016年 张嘉夫. All rights reserved.
//

import Cocoa
import SwiftyJSON

class TodayViewController: NSViewController {

    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var indicator: NSProgressIndicator!
    @IBOutlet weak var indicatorTextField: NSTextField!
    
    var games: JSON? {
        didSet {
            
            if tableView != nil { //没有显示的时候防止崩溃
                tableView.reloadData()
                indicator.isHidden = true
                indicatorTextField.isHidden = true
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        if games == nil {
            startIndicator()
        }
        
        indicator.startAnimation(nil)
        
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        startIndicator()
        DataLoader.shared.loadToday { (json) in
            self.games = json["gs"]["g"]
        }
    }
    
    func startIndicator() {
        indicator.isHidden = false
        indicatorTextField.isHidden = false
    }
    
    @IBAction func quit(_ sender: Any) {
        NSApplication.shared().terminate(sender)
    }
    
}

extension TodayViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return games?.count ?? 0
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        guard let game = games?[row] else {
            return nil
        }
        
        print("game:\(game)")
        
        var text = ""
        var team: JSON?
        if tableColumn == tableView.tableColumns[0] {
            //home
            team = game["h"]
        }else if tableColumn == tableView.tableColumns[1] {
            //visiting
            team = game["v"]
        }else if tableColumn == tableView.tableColumns[2] {
            text = game["stt"].string ?? ""
            text = NSLocalizedString(text, comment: "时间")
            
            if game["cl"].string != "00:00.0", let cl = game["cl"].string {
                text += " \(cl)"
            }
            
        }
        
        if let ta = team?["ta"].string, let s = team?["s"].int {
            text = "\(NSLocalizedString(ta, comment: "球队名字")) \(s)"
        }
        return text
    }
}
