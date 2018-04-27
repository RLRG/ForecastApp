//
//  WeatherRange.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 27/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation

struct WeatherRange {
    let startingTime: Int // IMPROVEMENT: Convert to Date. Now it is in UNIX TIME
    let temperatureAverage: Float
    let temperatureMin: Float
    let temperatureMax: Float
    let windSpeed: Float
    let windDegrees: Float
    let precipitation: Int
    let weatherIcon: String
}

