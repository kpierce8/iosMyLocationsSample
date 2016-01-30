//
//  Location.swift
//  MyLocations
//
//  Created by UberDominator on 1/24/16.
//  Copyright © 2016 Frantic Goose Applications. All rights reserved.
//

import Foundation
import CoreData
import MapKit

class Location: NSManagedObject, MKAnnotation {

    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(latitude, longitude)
    }
    
    
    var title: String? {
        if locationDescription.isEmpty {
            return "(No Description)"
        } else {
            return locationDescription
        }
    }

    var subtitle: String? {
        return category
    }
}
