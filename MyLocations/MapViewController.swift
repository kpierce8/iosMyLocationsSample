//
//  MapViewController.swift
//  MyLocations
//
//  Created by UberDominator on 1/28/16.
//  Copyright © 2016 Frantic Goose Applications. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController {
    
    
    var locations = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLocations()
        
        if !locations.isEmpty {
            showLocations()
        }
    }
    
    @IBOutlet   weak var mapView: MKMapView!
    
    //var managedObjectContext: NSManagedObjectContext!
    
    var coreDataStack = CoreDataStack()
    
    @IBAction func showUser(){
        let region = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 1000, 1000)
        
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
    }
    
    @IBAction func showLocations() {
        let region = regionForAnnotation(locations)
        mapView.setRegion(region, animated: true)
    }
    
    func updateLocations() {
        mapView.removeAnnotations(locations)
        
        let entity = NSEntityDescription.entityForName("Location", inManagedObjectContext: coreDataStack.context)
    
        let fetchRequest = NSFetchRequest()
    fetchRequest.entity = entity
    
    locations = try! coreDataStack.context.executeFetchRequest(fetchRequest) as! [Location]
    mapView.addAnnotations(locations)
    }

    func regionForAnnotation(annotations: [MKAnnotation]) -> MKCoordinateRegion {
        var region: MKCoordinateRegion
        
        switch annotations.count {
            case 0:
                region = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 1000, 1000)
                print("***No locations")
        case 1:
            let annotation = annotations[annotations.count-1]
             region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 1000, 1000)
            print("*** One location")

        default:
            var topLeftCoord = CLLocationCoordinate2D(latitude: -90, longitude: 180)
            var bottomRightCoord = CLLocationCoordinate2D(latitude: 90, longitude: -180)
            print("*** There are \(annotations.count) locations")

            for annotation in annotations {
                topLeftCoord.latitude = max(topLeftCoord.latitude, annotation.coordinate.latitude)
                topLeftCoord.longitude = min(topLeftCoord.longitude, annotation.coordinate.longitude)
                bottomRightCoord.latitude = min(topLeftCoord.latitude, annotation.coordinate.latitude)
                bottomRightCoord.longitude = max(topLeftCoord.longitude, annotation.coordinate.longitude)
            }

            let center = CLLocationCoordinate2D(latitude: topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude)/2, longitude: topLeftCoord.longitude - (topLeftCoord.longitude - bottomRightCoord.longitude)/2)
            print("center has lat \(center.latitude) and lon \(center.longitude)")
            let extraSpace = 1.1
            let span = MKCoordinateSpan(latitudeDelta: abs(topLeftCoord.latitude - bottomRightCoord.latitude) * extraSpace, longitudeDelta: abs(topLeftCoord.longitude - bottomRightCoord.longitude) * extraSpace)
            print("span has latD \(span.latitudeDelta) and lonD \(span.longitudeDelta)")
            region = MKCoordinateRegion(center: center, span: span)
        }
        return mapView.regionThatFits(region)
    }


}



extension MapViewController: MKMapViewDelegate {
    
}