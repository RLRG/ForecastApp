//
//  MainVCLocation.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 29/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation
import CoreLocation

/**
 TODO: Description
 */
extension MainVC: CLLocationManagerDelegate {
    
    /**
     TODO: Description
    */
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        AlertsManager.alert(caller: self, message: "Please, check that you have allowed your location services", title: "Operation error") {} // TODO: Remove constants
    }
    
    /**
     TODO: Description
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last
        lastLocation = newLocation
    }
}
