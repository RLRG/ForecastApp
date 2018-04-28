//
//  SearchWeatherUseCase.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 27/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation
import RxSwift

/**
 SearchWeatherUseCase
 
 Implementation of the logic to get the weather forecast information
 */
class SearchWeatherUseCase : SearchWeatherProtocol {
    
    // MARK: - Properties & Initialization
    
    /// Repository layer to call the searchWeather functionality
    private let repository: Repository
    /// Bag to dispose added disposables [RxSwift]
    private let disposeBag = DisposeBag()
    
    /**
     Initialization method for the SearchWeatherUseCase class
     - Parameter repository: The repository layer to call the SearchWeather functionality
     */
    init(repository: Repository) {
        self.repository = repository
    }
    
    // MARK: - Logic
    
    /**
     Get the weather forecast data for a city (optional) or for the lat/lon coordinates given.
     - Parameter name: the name of the city to look for. It is optional.
     - Parameter lat: the location latitude used to get the weather forecast.
     - Parameter lon: the location longitude used to get the weather forecast.
     - Returns: An Observable with WeatherResult objects
     */
    func getWeatherForecast(withName name: String?, withLat lat: Double, withLon lon: Double) -> Observable<WeatherResult> {
        return self.repository.getWeatherForecast(withName:name, withLat:lat, withLon:lon)
        // IMPROVEMENT: Manage errors here ! 
    }
}
