//
//  WeatherRange.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 27/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation

/**
 WeatherRange
 
 Model/Logic entity which contains the information for a 3-hour period of time
 */
public struct WeatherRange {
    let id: Int
    let startingTime: Date
    let temperatureAverage: Double
    let temperatureMin: Double
    let temperatureMax: Double
    let windSpeed: Double
    let windDegrees: Double
    let precipitation: Int
    let weatherIcon: String
}

