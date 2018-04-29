//
//  SearchWeather.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 27/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

/**
 TODO: Description
 */
class SearchWeather {
    /// TODO: Description
    private let network: Network<WeatherResult>
    
    /**
     TODO: Description
     - Parameter network:
     */
    init(network: Network<WeatherResult>) {
        self.network = network
    }
    
    /**
     TODO: Description
     - Parameter name:
     - Parameter lat:
     - Parameter lon:
     - Returns:
     */
    func getWeatherResult(withName name: String?, withLat lat: Double, withLon lon: Double) -> Observable<WeatherResult> {
        if let cityName = name, cityName != "" {
            // URL example: "https://api.openweathermap.org/data/2.5/?APPID=81ad19519a94fc70c162cd0b4d9e564d&lat=35&lon=139"
            return network.getRequest("\(Urls.searchWeatherMethod)\(API.APPID)&q=\(cityName)", rootJSONEntity: "")
            
        } else {
            // URL example: "https://api.openweathermap.org/data/2.5/?APPID=81ad19519a94fc70c162cd0b4d9e564d&q=London,uk"
            return network.getRequest("\(Urls.searchWeatherMethod)\(API.APPID)&lat=\(lat)&lon=\(lon)", rootJSONEntity: "")
        }
    }
}

/**
 TODO: Description
 */
extension WeatherResult: ImmutableMappable {
    /**
     JSON -> Object
    */
    public init(map: Map) throws {
        
        // City
        if let cityName = map.JSON["city.name"] {
            city = City(name: cityName as! String, timeRequested: Date()) // swiftlint:disable:this force_cast
        } else {
            city = City(name: "", timeRequested: Date())
        }
        
        // Location
        if let coord = map.JSON["city.coord"] as! [String:Any]?, // swiftlint:disable:this force_cast
            let coord_lat = coord["lat"],
            let coord_lon = coord["lon"] {
            location = Location(lat: coord_lat as! Double, lon: coord_lon as! Double) // swiftlint:disable:this force_cast
        } else {
            location = Location(lat: 0, lon: 0)
        }
        
        // WeatherRange array
        weatherRanges = try map.value("list")
    }
}

/**
 TODO: Description
 */
extension WeatherRange: ImmutableMappable {
    /**
     JSON -> Object
     */
    public init(map: Map) throws {
        
        // StartingTime
        startingTime = try map.value("dt") // IMPROVEMENT: Conversion to Date !
        
        // Temperatures
        temperatureAverage = try map.value("main.temp")
        temperatureMin = try map.value("main.temp_min")
        temperatureMax = try map.value("main.temp_max")
        
        // Wind
        windSpeed = try map.value("wind.speed")
        windDegrees = try map.value("wind.deg")
        
        // Precipitation
        precipitation = try map.value("clouds.all")
        
        // Weather Icon
        if let weatherObjects = map.JSON["weather"] as! NSArray?, // swiftlint:disable:this force_cast
            let weather = weatherObjects[0] as? [String:Any],
            let iconDescription = weather["icon"] {
            weatherIcon = iconDescription as! String // swiftlint:disable:this force_cast
        } else {
            weatherIcon = ""
        }
    }
}
