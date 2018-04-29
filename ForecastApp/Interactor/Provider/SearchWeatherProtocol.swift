//
//  SearchWeatherProtocol.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 27/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation
import RxSwift

/**
 SearchWeatherProtocol
 
 List of methods needed to get the weather forecast information
 */
public protocol SearchWeatherProtocol {
    /**
     Get the weather forecast data for a city (optional) or for the lat/lon coordinates given.
     - Parameter name: the name of the city to look for. It is optional.
     - Parameter lat: the location latitude used to get the weather forecast.
     - Parameter lon: the location longitude used to get the weather forecast.
     - Returns: An Observable with WeatherResult objects
     */
    func getWeatherForecast(withName name: String?, withLat lat: Double, withLon lon: Double) -> Observable<WeatherResult>
}
