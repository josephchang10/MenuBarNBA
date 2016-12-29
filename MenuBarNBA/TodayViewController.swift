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
    
    var games: JSON? {
        didSet {
            
            if tableView != nil { //没有显示的时候防止崩溃
                tableView.reloadData()
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        DataLoader.shared.loadToday { (json) in
            self.games = json["gs"]["g"]
        }
    }
    
    @IBAction func quit(_ sender: Any) {
        NSApplication.shared().terminate(sender)
    }
    
}

extension TodayViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return games?.count ?? 0
    }
}

extension TodayViewController: NSTableViewDelegate {
    
    fileprivate enum CellIdentifiers {
        static let TeamCell = "TeamCellID"
        static let TimeCell = "TimeCellID"
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let game = games?[row] else {
            return nil
        }
        
        print("game:\(game)")
        
        var text = ""
        var team: JSON?
        var cellIdentifier = CellIdentifiers.TeamCell
        if tableColumn == tableView.tableColumns[0] {
            //home
            team = game["h"]
        }else if tableColumn == tableView.tableColumns[1] {
            //visiting
            team = game["v"]
        }else if tableColumn == tableView.tableColumns[2] {
            cellIdentifier = CellIdentifiers.TimeCell
            text = game["stt"].string ?? ""
            
            if game["cl"].string != "00:00.0", let cl = game["cl"].string {
                text += " \(cl)"
            }
            
        }
        
        if let ta = team?["ta"].string, let s = team?["s"].int {
            text = "\(ta) \(s)"
        }
        
        if let cell = tableView.make(withIdentifier: cellIdentifier, owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            return cell
        }
        return nil
    }
}
