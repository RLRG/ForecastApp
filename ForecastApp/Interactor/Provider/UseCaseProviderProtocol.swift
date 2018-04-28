//
//  UseCaseProviderProtocol.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 27/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation

/**
 UseCaseProviderProtocol
 
 Protocol listing the functions that mut be developed by the class responsible for implementing the logic to create the use cases, i.e., the interactor functionality
 */
protocol UseCaseProviderProtocol {
    
    // MARK: - Weather
    func makeSearchWeatherUseCase() -> SearchWeatherProtocol
}
