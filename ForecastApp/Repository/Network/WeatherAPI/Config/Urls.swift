//
//  Urls.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 27/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation

/**
Urls

This struct lists all the web services offered by the server of the system. The struct provides the URL string for each specific web service for the Weather API.
*/
struct Urls {
    
    // MARK: - Weather
    /// URL full example: "https://api.openweathermap.org/data/2.5/forecast?APPID=81ad19519a94fc70c162cd0b4d9e564d&lat=35&lon=139"
    static let searchWeatherMethod = "forecast" // HTTP method: GET
}
