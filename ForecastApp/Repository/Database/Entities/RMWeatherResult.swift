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
    @objc dynamic var city: RMCity!
    @objc dynamic var location: RMLocation!
    // @objc dynamic var weatherRanges: [RMWeatherRange]! // TODO: Pending to fix!
}

/**
 Converts RMWeatherResult to application domain WeatherResult
 */
extension RMWeatherResult: DomainConvertibleType {
    func asDomain() -> WeatherResult {
        return WeatherResult(city: city.asDomain(),
                             location: location.asDomain(),
                             weatherRanges: []) // TODO: Pending to fix!
    }
}

/**
 Represents WeatherResult as RMWeatherResult
 */
extension WeatherResult: RealmRepresentable {
    func asRealm() -> RMWeatherResult {
        return RMWeatherResult.build { object in
            object.city = city.asRealm()
            object.location = location.asRealm()
            // object.weatherRanges = weatherRanges // TODO: Pending to fix!
        }
    }
}
