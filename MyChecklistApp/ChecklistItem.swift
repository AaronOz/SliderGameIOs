//
//  ChecklistItem.swift
//  MyChecklistApp
//
//  Created by x0163855 on 3/29/16.
//  Copyright © 2016 Martz. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject {
    var text = ""
    var score = "0"
    var checked = false
  
  func toggleChecked() {
    checked = !checked
  }
    func updateScore( newScore : String){        
        score = newScore
    }
}