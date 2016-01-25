//
//  Functions.swift
//  MyLocations
//
//  Created by UberDominator on 1/24/16.
//  Copyright © 2016 Frantic Goose Applications. All rights reserved.
//

import Foundation
import Dispatch

func afterDelay(seconds: Double, closure: () -> ()) {
    let when = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
    dispatch_after(when, dispatch_get_main_queue(), closure)
}