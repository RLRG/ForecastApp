//
//  ServerProviderProtocol.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 27/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation
import RxSwift

/**
 ServerProviderProtocol
 
 List of methods provided by the server that the app is able to call to get the data of the system.
 */
protocol ServerProviderProtocol {
    func getWeatherForecast(withName name: String?, withLat lat: Double, withLon lon: Double) -> Observable<WeatherResult>
}
