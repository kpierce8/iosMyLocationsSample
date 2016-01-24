//
//  SecondViewController.swift
//  MyLocations
//
//  Created by UberDominator on 11/18/15.
//  Copyright © 2015 Frantic Goose Applications. All rights reserved.
//

import UIKit
import CoreLocation

class LocationDetailsViewController: UITableViewController {

    var coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var placemark: CLPlacemark?
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!

    @IBAction func done(){
    dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func cancel(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

