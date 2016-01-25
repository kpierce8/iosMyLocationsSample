//
//  CategoriesViewController.swift
//  MyLocations
//
//  Created by UberDominator on 1/24/16.
//  Copyright © 2016 Frantic Goose Applications. All rights reserved.
//

import UIKit

class CategoriesViewController: UITableViewController {
    var selectedcategory = ""
    
    let categories = [
    "Eeeny",
    "Meeny",
    "Mini"]
    
    var selectedIndexPath = NSIndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0..<categories.count {
            if categories[i] == selectedcategory {
                selectedIndexPath = NSIndexPath(forRow: i, inSection: 0)
                break
            } else {
                selectedIndexPath = NSIndexPath(forRow: 0, inSection: 0)
            }
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("categoryCell", forIndexPath: indexPath)
        
        let categoryName = categories[indexPath.row]
        
        cell.textLabel!.text = categoryName
        
        if categoryName == selectedcategory {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row != selectedIndexPath.row {
            if let newCell = tableView.cellForRowAtIndexPath(indexPath) {
                newCell.accessoryType = .Checkmark
            }
            
            if let oldCell = tableView.cellForRowAtIndexPath(selectedIndexPath) {
                oldCell.accessoryType = .None
            }
            selectedIndexPath = indexPath
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PickedCategory" {
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPathForCell(cell) {
                selectedcategory = categories[indexPath.row]
            }
        }
    }
    
}