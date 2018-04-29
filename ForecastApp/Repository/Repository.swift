//
//  Repository.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 27/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation
import RxSwift

/**
 Repository
 
 Main Repository layer which is responsible for managing the calls to the network and to the local database. Uppers layers should not know what is happening behind the scenes.
 */
class Repository {
    
    // MARK: - Properties & Initialization
    
    /// Bag to dispose added disposables [RxSwift]
    internal let disposeBag = DisposeBag()
    
    // MARK: Network
    /// ServerProvider allowing the app to communicate with the server
    internal let networkServerProvider: ServerProviderProtocol
    
    // MARK: Database
    /// Local database table for the weatherResults
    internal let weatherResults: AbstractRepository<WeatherResult>
    /// Local database table for locations
    internal let locations: AbstractRepository<Location>
    /// Local database table for the cities looked for
    internal let cities: AbstractRepository<City>
    /// Local database table for each weather range
    internal let weatherRanges: AbstractRepository<WeatherRange>
    
    // MARK: UserDefaults
    /// Storage layer to store small pieces of information such as configuration values
    internal let userDefaults: UserDefaults
    
    // MARK: Initialization
    /**
     Initialization method for the main Repository layer of the app
     - Parameter serverProvider: ServerProvider allowing the app to communicate with the server
     - Parameter userRepo: Local database table for the active user of the app
     - Parameter vehiclesRepo: Local database table for the vehicles belonging to the system
     - Parameter reservationsRepo: Local database table for the bookings belonging to the system
     - Parameter userDefaults: Storage layer to store small pieces of information such as configuration values
     */
    init(serverProvider: ServerProviderProtocol, weatherResultsRepo: AbstractRepository<WeatherResult>, locationsRepo: AbstractRepository<Location>, citiesRepo: AbstractRepository<City>, weatherRangesRepo: AbstractRepository<WeatherRange>, userDefaults: UserDefaults) {
        
        self.networkServerProvider = serverProvider
        
        self.weatherResults = weatherResultsRepo
        self.locations = locationsRepo
        self.cities = citiesRepo
        self.weatherRanges = weatherRangesRepo
        
        self.userDefaults = userDefaults
    }
    
    
    // MARK: - Weather
    
    /**
     Get the weather forecast data for a city (optional) or for the lat/lon coordinates given.
     - Parameter name: the name of the city to look for. It is optional.
     - Parameter lat: the location latitude used to get the weather forecast.
     - Parameter lon: the location longitude used to get the weather forecast.
     - Returns: An Observable with WeatherResult objects
     */
    func getWeatherForecast(withName name: String?, withLat lat: Double, withLon lon: Double) -> Observable<WeatherResult> {
        
        return Observable.of(getLastWeatherForecastFromDB().take(1), networkServerProvider.getWeatherForecast(withName:name, withLat:lat, withLon:lon).do(onNext: { (weatherResult) in
            #if DEBUG
            print("NETWORK - getWeatherForecast() successful.")
            #endif

            // Save the data in local DB when the network request response arrives
            self.weatherResults.save(entity: weatherResult).subscribe().disposed(by: self.disposeBag) // TODO: FIX THIS !!
        })).merge()
    }
    
    // MARK: - Local database
    
    // MARK: WeatherResult
    
    /**
     TODO: Description
    */
    func getLastWeatherForecastFromDB() -> Observable<WeatherResult> {
        return weatherResults.query()
    }
    
}
