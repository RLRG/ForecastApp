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
 MainVC extension responsible for getting the locations of the current user.
 */
extension MainVC: CLLocationManagerDelegate {
    
    /**
     Tells the delegate that the location manager was unable to retrieve a location value.
     manager
     - Parameter manager: The location manager object that was unable to retrieve the location.
     error
     - Parameter error: The error object containing the reason the location or heading could not be retrieved.
    */
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        presenter.displayError(with: UIMessages.errorLocationServicesTitle, and: UIMessages.errorLocationServices)
    }
    
    /**
     Tells the delegate that new location data is available.
     - Parameter manager: The location manager object that generated the update event.
     - Parameter locations: An array of CLLocation objects containing the location data.
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last
        lastLocation = newLocation
    }
}
