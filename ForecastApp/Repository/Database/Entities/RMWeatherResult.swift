//
//  RMWeatherResult.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 27/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

/**
 RMWeatherResult
 
 Realm database entity for WeatherResult
 */
final class RMWeatherResult: Object {
    @objc dynamic var weatherResultID: String = ""
    @objc dynamic var city: RMCity!
    @objc dynamic var location: RMLocation!
    let weatherRanges = List<RMWeatherRange>()
    
    override class func primaryKey() -> String? {
        return "weatherResultID"
    }
}

/**
 Converts RMWeatherResult to application domain WeatherResult
 */
extension RMWeatherResult: DomainConvertibleType {
    func asDomain() -> WeatherResult {
        var tempWeatherRanges = [WeatherRange]()
        for rmWeatherRange in weatherRanges {
            tempWeatherRanges.append(rmWeatherRange.asDomain())
        }
        return WeatherResult(weatherResultID: weatherResultID,
                             city: city.asDomain(),
                             location: location.asDomain(),
                             weatherRanges: tempWeatherRanges)
    }
}

/**
 Represents WeatherResult as RMWeatherResult
 */
extension WeatherResult: RealmRepresentable {
    func asRealm() -> RMWeatherResult {
        let tempRMWeatherRanges = List<RMWeatherRange>()
        for weatherRange in weatherRanges {
            tempRMWeatherRanges.append(weatherRange.asRealm())
        }
        return RMWeatherResult.build { object in
            object.weatherResultID = weatherResultID
            object.city = city.asRealm()
            object.location = location.asRealm()
            object.weatherRanges.append(objectsIn: tempRMWeatherRanges)
        }
    }
}
