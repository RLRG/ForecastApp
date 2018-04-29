//
//  TestData.swift
//  ForecastAppTests
//
//  Created by Rodrigo López-Romero Guijarro on 27/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation

@testable import ForecastApp

struct TestData {
    
    static let city = City(name: "Valladolid", timeRequested: Date())
    static let location = Location(locationName: "Valladolid", lat: 41.65518, lon: -4.72372)
    
    static let weatherRange0 = WeatherRange(id: 0, startingTime: Date(), temperatureAverage: 12, temperatureMin: 8, temperatureMax: 16, windSpeed: 2.5, windDegrees: 200, precipitation: 20, weatherIcon: "01d")
    static let weatherRange1 = WeatherRange(id: 1, startingTime: Date(), temperatureAverage: 15, temperatureMin: 10, temperatureMax: 20, windSpeed: 2.5, windDegrees: 200, precipitation: 0, weatherIcon: "01n")
    static let weatherRange2 = WeatherRange(id: 2, startingTime: Date(), temperatureAverage: 20, temperatureMin: 15, temperatureMax: 25, windSpeed: 2.5, windDegrees: 200, precipitation: 0, weatherIcon: "01d")
    static let weatherRange3 = WeatherRange(id: 3, startingTime: Date(), temperatureAverage: 25, temperatureMin: 20, temperatureMax: 30, windSpeed: 2.5, windDegrees: 200, precipitation: 20, weatherIcon: "01n")
    
    static let weatherRanges = [weatherRange0, weatherRange1, weatherRange2, weatherRange3]
    
    static let weatherResult = WeatherResult(weatherResultID: "ResultID", city: city, location: location, weatherRanges: weatherRanges)
}
