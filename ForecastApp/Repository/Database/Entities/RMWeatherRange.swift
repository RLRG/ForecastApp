//
//  RMWeatherRange.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 28/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

/**
 RMWeatherRange
 
 Realm database entity for the the weather ranges
 */
final class RMWeatherRange: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var startingTime: Date = Date()
    @objc dynamic var temperatureAverage: Double = 0.0
    @objc dynamic var temperatureMin: Double = 0.0
    @objc dynamic var temperatureMax: Double = 0.0
    @objc dynamic var windSpeed: Double = 0.0
    @objc dynamic var windDegrees: Double = 0.0
    @objc dynamic var precipitation: Int = 0
    @objc dynamic var weatherIcon: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

/**
 Converts RMWeatherRange to application domain WeatherRange
 */
extension RMWeatherRange: DomainConvertibleType {
    func asDomain() -> WeatherRange {
        return WeatherRange(id: id,
                            startingTime: startingTime,
                            temperatureAverage: temperatureAverage,
                            temperatureMin: temperatureMin,
                            temperatureMax: temperatureMax,
                            windSpeed: windSpeed,
                            windDegrees: windDegrees,
                            precipitation: precipitation,
                            weatherIcon: weatherIcon)
    }
}

/**
 Represents WeatherRange as RMWeatherRange
 */
extension WeatherRange: RealmRepresentable {
    func asRealm() -> RMWeatherRange {
        return RMWeatherRange.build { object in
            object.id = id
            object.startingTime = startingTime
            object.temperatureAverage = temperatureAverage
            object.temperatureMin = temperatureMin
            object.temperatureMax = temperatureMax
            object.windSpeed = windSpeed
            object.windDegrees = windDegrees
            object.precipitation = precipitation
            object.weatherIcon = weatherIcon
        }
    }
}
