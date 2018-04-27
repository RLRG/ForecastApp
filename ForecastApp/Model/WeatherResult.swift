//
//  WeatherResult.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 27/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation

struct WeatherResult {
    let temperature: Float
    let windSpeed: Float
    let windDegrees: Float
    let precipitation: Int
    let weatherIcon: String
    let city: City
    let location: Location
}
