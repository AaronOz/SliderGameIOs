//
//  AppDelegate.swift
//  MyChecklistApp
//
//  Created by Aaron Delgado on 15/03/16.
//  Copyright © 2016 Aarond. All rights reserved.
//

import Foundation

protocol AddItemViewControllerDelegate: class {
  func addItemViewControllerDidCancel(controller:AddItemViewController)
  func addItemViewController(controller:AddItemViewController, didFinishAddingItem item: ChecklistItem)
  func addItemViewController(controller:AddItemViewController, didFinishEditingItem item: ChecklistItem)
}