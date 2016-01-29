//
//  SecondViewController.swift
//  MyLocations
//
//  Created by UberDominator on 11/18/15.
//  Copyright © 2015 Frantic Goose Applications. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

private let dateFormatter: NSDateFormatter = {
    let formatter = NSDateFormatter()
    formatter.dateStyle = .MediumStyle
    formatter.timeStyle = .ShortStyle
    return formatter
    } ()


class LocationDetailsViewController: UITableViewController {

    var coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var placemark: CLPlacemark?
    var categoryName = "No Category"
    var descriptionText = ""
    var date: NSDate?
    var coreDataStack = CoreDataStack()
    var managedObjectContext: NSManagedObjectContext!
    var locationToEdit: Location? {
        didSet {
            if let location = locationToEdit {
                descriptionText = location.locationDescription
                categoryName = location.category
                date = location.date
                coordinate = CLLocationCoordinate2DMake(location.latitude, location.longitude)
                placemark = location.placemark
            }
        }
    }
    var descriptionEdit = ""
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!

    @IBAction func done(){
        let location = NSEntityDescription.insertNewObjectForEntityForName("Location", inManagedObjectContext: coreDataStack.context) as! Location
        
        location.locationDescription = descriptionTextView.text
        location.category = categoryName
        location.latitude  = coordinate.latitude
        location.longitude = coordinate.longitude
        location.date = NSDate()
        location.placemark = placemark
        
        do {
            try coreDataStack.context.save()
        } catch {
            fatalError("Error: \(error)")
        }
        afterDelay(0.6){
          self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    @IBAction func cancel(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func formatDate(date: NSDate) -> String{
        return dateFormatter.stringFromDate(date)
    }
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
        let location: Location
        if let temp = locationToEdit {
            location = temp
        } else {
            location = NSEntityDescription.insertNewObjectForEntityForName("Location", inManagedObjectContext: coreDataStack.context) as! Location
            
        }
        
        
        let hf = HelperFunctions()
        longitudeLabel.text = String(format: "%.8f", coordinate.longitude)
        latitudeLabel.text = String(format: "%.8f", coordinate.latitude)
        descriptionTextView.text = descriptionText
        categoryLabel.text = categoryName
        
        if let placemark = placemark {
            addressLabel.text = hf.stringFromPlacemark(placemark)
        } else {
            addressLabel.text = "No Address Found"
        }
        dateLabel.text = formatDate(NSDate())
        managedObjectContext = coreDataStack.context
    }

    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath == 0 {
            return 88
        } else if indexPath.section == 2 && indexPath.row == 2 {
            addressLabel.frame.size = CGSize(width: view.bounds.size.width - 115, height: 10000)
            addressLabel.sizeToFit()
            addressLabel.frame.origin.x = view.bounds.size.width - addressLabel.frame.size.width - 15
            
            return addressLabel.frame.size.height + 20
        } else {
            return 44
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PickCategory" {
            let controller = segue.destinationViewController as! CategoriesViewController
            controller.selectedcategory = categoryName
        }
    }
    
    
    @IBAction func categoryPickerDidPickCategory(segue: UIStoryboardSegue) {
        let controller = segue.sourceViewController as! CategoriesViewController
        categoryName = controller.selectedcategory
        categoryLabel.text = categoryName
    }
}

