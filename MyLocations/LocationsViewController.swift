//
//  LocationsViewController.swift
//  MyLocations
//
//  Created by UberDominator on 1/24/16.
//  Copyright © 2016 Frantic Goose Applications. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class LocationsViewController: UITableViewController {

    let coredataStack = CoreDataStack()
    var locations = [Location]()

    
    override func viewDidLoad(){
     let fetchLocations = NSFetchRequest()
     let entity = NSEntityDescription.entityForName("Location", inManagedObjectContext: coredataStack.context)


    fetchLocations.entity = entity
        
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchLocations.sortDescriptors = [sortDescriptor]
        
        do {
            let foundObjects = try coredataStack.context.executeFetchRequest(fetchLocations)
            
            locations = foundObjects as! [Location]
        
        } catch {
            fatalError("oops")
        }
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    //MARK Tableview Methods
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LocationCell", forIndexPath: indexPath)
        
        let descriptionLabel = cell.viewWithTag(100) as! UILabel
        descriptionLabel.text = locations[indexPath.row].locationDescription
 
        let addressLabel = cell.viewWithTag(101) as! UILabel
        let hf = HelperFunctions()
        if let placemark = locations[indexPath.row].placemark {
            addressLabel.text = hf.stringFromPlacemark(placemark)
        } else {
            addressLabel.text = "No Address Found"
        }
      

        return cell
    }
    
}