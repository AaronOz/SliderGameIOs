//
//  AppDelegate.swift
//  MyChecklistApp
//
//  Created by Aaron Delgado on 15/03/16.
//  Copyright © 2016 Aarond. All rights reserved.
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