//
//  HelperFunctions.swift
//  MyLocations
//
//  Created by UberDominator on 1/24/16.
//  Copyright © 2016 Frantic Goose Applications. All rights reserved.
//

import UIKit
import CoreLocation

class HelperFunctions {

    func stringFromPlacemark(placemark: CLPlacemark) -> String {
        var line1 = ""
        if let s = placemark.subThoroughfare {
            line1 += s + " "
        }
        if let s = placemark.thoroughfare {
            line1 += s + " "
        }
        
        var line2 = ""
        if let s = placemark.locality {
            line2 += s + " "
        }
        if let s = placemark.administrativeArea {
            line2 += s + " "
        }
        if let s = placemark.postalCode {
            line2 += s
        }
        
        return line1 + "\n" + line2
    }

    
}