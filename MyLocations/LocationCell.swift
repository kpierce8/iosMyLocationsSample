//
//  LocationCell.swift
//  MyLocations
//
//  Created by UberDominator on 1/26/16.
//  Copyright © 2016 Frantic Goose Applications. All rights reserved.
//

import UIKit

class LocationCell : UITableViewCell {
    @IBOutlet weak var desciptionLabel: UILabel!
    @IBOutlet weak var addresslabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!

    func imageForLocation(location: Location) -> UIImage {
        if location.hasPhoto, let image = location.photoImage {
            return image.resizedImageWithBounds(CGSize(width: 52, height: 52))
        }
        return UIImage()
    }
    
    
}