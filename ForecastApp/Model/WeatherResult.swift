//
//  WeatherResult.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 27/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation

/**
 WeatherResult
 
 Model/Logic entity which contains all the weather forecast data.
 */
public struct WeatherResult {
    let weatherResultID: String
    let city: City
    let location: Location
    var weatherRanges: [WeatherRange]
}
