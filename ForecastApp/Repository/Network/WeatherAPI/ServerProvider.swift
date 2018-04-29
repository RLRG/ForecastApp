//
//  ServerProvider.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 27/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation
import RxSwift

/**
 ServerProvider
 
 The class providing the calls to the web services offered by the main endpoint server of the system. It conforms the ServerProviderProtocol.
 */
class ServerProvider : ServerProviderProtocol {
    
    // MARK: - Properties & Initialization
    
    /// The IP/URL identifier of the server from the one the data is obtained
    private let apiEndpoint: String
    /// Bag to dispose added disposables [RxSwift]
    private let disposeBag = DisposeBag()
    
    /**
     Initialization method for the ServerProvider class
     */
    public init() {
        apiEndpoint = API.endpoint
    }
    
    // MARK: - Weather API
    
    /**
     Get the weather forecast data for a city (optional) or for the lat/lon coordinates given.
     - Parameter name: the name of the city to look for. It is optional.
     - Parameter lat: the location latitude used to get the weather forecast.
     - Parameter lon: the location longitude used to get the weather forecast.
     - Returns: An Observable with WeatherResult objects
    */
    func getWeatherForecast(withName name: String?, withLat lat: Double, withLon lon: Double) -> Observable<WeatherResult> {
        let network = Network<WeatherResult>(apiEndpoint)
        let webService = SearchWeather(network: network)
        return webService.getWeatherResult(withName:name, withLat:lat, withLon:lon)
    }
    
}
