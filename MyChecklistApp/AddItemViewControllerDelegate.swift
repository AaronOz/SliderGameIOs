//
//  AddItemViewControllerDelegate.swift
//  MyChecklistApp
//
//  Created by Mario G on 12/04/16.
//  Copyright © 2016 Martz. All rights reserved.
//

import Foundation

protocol AddItemViewControllerDelegate: class {
  func addItemViewControllerDidCancel(controller:AddItemViewController)
  func addItemViewController(controller:AddItemViewController, didFinishAddingItem item: ChecklistItem)
  func addItemViewController(controller:AddItemViewController, didFinishEditingItem item: ChecklistItem)
}