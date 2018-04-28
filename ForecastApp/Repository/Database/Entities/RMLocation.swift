//
//  RMLocation.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 27/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

/**
 RMLocation
 
 Realm database entity for lat/lon location
 */
final class RMLocation: Object {
    @objc dynamic var lat: Double = 0
    @objc dynamic var lon: Double = 0
}

/**
 Converts RMLocation to application domain Location
 */
extension RMLocation: DomainConvertibleType {
    func asDomain() -> Location {
        return Location(lat: lat,
                        lon: lon)
    }
}

/**
 Represents Location as RMLocation
 */
extension Location: RealmRepresentable {
    func asRealm() -> RMLocation {
        return RMLocation.build { object in
            object.lat = lat
            object.lon = lon
        }
    }
}
