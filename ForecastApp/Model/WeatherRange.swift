//
//  WeatherRange.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 27/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation

/**
 TODO: Description
 */
public struct WeatherRange {
    let startingTime: Int // IMPROVEMENT: Convert to Date. Now it is in UNIX TIME
    let temperatureAverage: Double
    let temperatureMin: Double
    let temperatureMax: Double
    let windSpeed: Double
    let windDegrees: Double
    let precipitation: Int
    let weatherIcon: String
}

