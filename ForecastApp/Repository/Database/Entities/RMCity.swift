//
//  RMCity.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 28/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

/**
 RMCity
 
 Realm database entity for the cities
 */
final class RMCity: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var timeRequested: Date = Date()
    
    override class func primaryKey() -> String? {
        return "name"
    }
}

/**
 Converts RMCity to application domain City
 */
extension RMCity: DomainConvertibleType {
    func asDomain() -> City {
        return City(name: name,
                    timeRequested: timeRequested)
    }
}

/**
 Represents City as RMCity
 */
extension City: RealmRepresentable {
    func asRealm() -> RMCity {
        return RMCity.build { object in
            object.name = name
            object.timeRequested = timeRequested
        }
    }
}
