//
//  ViewController.swift
//  MyChecklistApp
//
//  Created by Aaron D. on 15/03/16.
//  Copyright © 2016 Aarond. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {
    
    var selectedItem = ""
    var playerScore = 0
    var items: [ChecklistItem]
    var indexPathCell : Int?
    var cellLabel : UILabel?
      
  required init?(coder aDecoder: NSCoder) {
    items = [ChecklistItem]()
    
    let checklistItem = ChecklistItem()
    checklistItem.text = "Aaron"
    checklistItem.score = "10"
    checklistItem.checked = true
    items.append(checklistItem)
    super.init(coder: aDecoder)
  }
    
  func addItem(item: ChecklistItem) {
    let nextIndex = items.count
    let indexPath = NSIndexPath(forRow: nextIndex, inSection: 0)
    items.append(item)
    tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
  }
  //Catch data from SliderViewController without segue
    @IBAction func unwindToVC(segue:UIStoryboardSegue){
        if let svc = segue.sourceViewController as? SliderViewController{
            //If the score is higher to old Score
            if(svc.score > playerScore){
                playerScore = svc.score
            }
            items[indexPathCell!].score = String(playerScore)
            cellLabel?.text = items[indexPathCell!].score //Selected cell
        }
    }
    
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    
    items.removeAtIndex(indexPath.row)
    
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
  }
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem", forIndexPath: indexPath)
    let item = items[indexPath.row]
    
    configureTextForCell(cell, withChecklistItem: item)
    configureCheckmarkForCell(cell, withChecklistItem: item)
    return cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if let cell = tableView.cellForRowAtIndexPath(indexPath) {
      let item = items[indexPath.row]
        indexPathCell = indexPath.row
      configureCheckmarkForCell(cell, withChecklistItem: item)
    }
    tableView.deselectRowAtIndexPath(indexPath, animated: true)    
  }
  
  func configureTextForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem) {
    let label = cell.viewWithTag(1000) as! UILabel
    label.text = item.text
    selectedItem = item.text
  }
  
  func configureCheckmarkForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem) {
    let label = cell.viewWithTag(1002) as! UILabel
    label.text = item.score
    cellLabel = label
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func addItemViewControllerDidCancel(controller: AddItemViewController) {
    dismissViewControllerAnimated(true, completion: nil)
  }

  func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: ChecklistItem) {
    addItem(item)
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func addItemViewController(controller:AddItemViewController, didFinishEditingItem item: ChecklistItem) {
    if let index = items.indexOf(item) {
      let indexPath = NSIndexPath(forRow: index, inSection: 0)
      let cell = tableView.cellForRowAtIndexPath(indexPath)
      configureTextForCell(cell!, withChecklistItem: item)
    }
    dismissViewControllerAnimated(true, completion: nil)
  }
    
    
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "AddItem" {
      let navigatorController = segue.destinationViewController as! UINavigationController
      let controller = navigatorController.topViewController as! AddItemViewController
      controller.delegate = self
    }
    if segue.identifier == "editItem" {
      let navigatorController = segue.destinationViewController as! UINavigationController
      let controller = navigatorController.topViewController as! AddItemViewController
        controller.delegate = self
    
      if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
        controller.selectedItem = items[indexPath.row]
        }
    }
    if(segue.identifier == "GameOn"){
        let DestViewController : SliderViewController = segue.destinationViewController as! SliderViewController
        DestViewController.playerLabel = selectedItem
        DestViewController.playerScoreStr = (cellLabel?.text)!
        if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
            DestViewController.selectedItem = items[indexPath.row]
        }
        
    }
  }
}

