//
//  API_LAB.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 27/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation

/**
 API
 
 This struct provide the endpoint URL for the Weather API for the testing LAB environment. For now, it will be the same as the production environment endpoint.
 */
struct API {
    /// URL for OpenWeatherMap API
    static let endpoint = "https://api.openweathermap.org/data/2.5/"
    /// The APP identifier to get data from the OpenWeather API
    static let APPID = "?APPID=81ad19519a94fc70c162cd0b4d9e564d"
}
