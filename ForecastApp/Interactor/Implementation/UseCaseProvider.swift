//
//  UseCaseProvider.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 27/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation

/**
 UseCaseProvider
 
 Final class responsible for creating all the use cases available in the Interactor layer and that can be exploited by the upper layer whose name is Presentation and the objects using these use cases are called "Presenters".
 */
public final class UseCaseProvider: UseCaseProviderProtocol {
    
    // MARK: - Properties & Initialization
    
    /// Repository layer to store and retrieve data
    private let repository: Repository
    
    /**
     Initialization method for the UseCaseProvider class
     - Parameter repository: Repository layer to store and retrieve data
     */
    init(with repository: Repository) {
        self.repository = repository
    }
    
    
    // MARK: - Weather
    
    /**
     Create the use case that allows to get the weather forecast information
     - Returns: the use case to get the weather forecast information
     */
    func makeSearchWeatherUseCase() -> SearchWeatherProtocol {
        return SearchWeatherUseCase(repository: repository)
    }
}
