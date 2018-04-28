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
    @objc dynamic var startingTime: Int = 0 // IMPROVEMENT: Convert to Date. Now it is in UNIX TIME
    @objc dynamic var temperatureAverage: Float = 0.0
    @objc dynamic var temperatureMin: Float = 0.0
    @objc dynamic var temperatureMax: Float = 0.0
    @objc dynamic var windSpeed: Float = 0.0
    @objc dynamic var windDegrees: Float = 0.0
    @objc dynamic var precipitation: Int = 0
    @objc dynamic var weatherIcon: String = ""
}

/**
 Converts RMWeatherRange to application domain WeatherRange
 */
extension RMWeatherRange: DomainConvertibleType {
    func asDomain() -> WeatherRange {
        return WeatherRange(startingTime: startingTime,
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
