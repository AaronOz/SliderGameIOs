//
//  AppDelegate.swift
//  MyChecklistApp
//
//  Created by Aaron Delgado on 15/03/16.
//  Copyright © 2016 Aarond. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController, UITextFieldDelegate {
  
  weak var delegate: AddItemViewControllerDelegate?
  weak var selectedItem: ChecklistItem?
  
  @IBOutlet weak var textField: UITextField!
  
  @IBOutlet weak var doneBarButton: UIBarButtonItem!
  override func viewWillAppear(animated: Bool) {
    textField.becomeFirstResponder()
    doneBarButton.enabled = false
    if let item = selectedItem {
      navigationItem.title = "Edit Item"
      textField.text = item.text
      doneBarButton.enabled = true
    }
    super.viewWillAppear(animated)
  }
  
  @IBAction func done(sender: AnyObject) {
    if let item = selectedItem {
      item.text = textField.text!
      delegate?.addItemViewController(self, didFinishEditingItem: item)
    }else {
      let item = ChecklistItem()
      item.text = textField.text!
      
      delegate?.addItemViewController(self, didFinishAddingItem: item)
    }
  }
  
  
  @IBAction func cancel(sender: AnyObject) {
    delegate?.addItemViewControllerDidCancel(self)
  }
  
  override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    return nil
  }
  
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    if let text = textField.text {
      if !text.isEmpty {
        doneBarButton.enabled = true
      }else {
        doneBarButton.enabled = false
      }
    }
    return true
  }
}
