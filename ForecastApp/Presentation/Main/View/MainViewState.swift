//
//  MainViewState.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 28/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation

/**
 MainViewState
 
 List of possible view states for the home view screen
 */
enum MainViewState {
    case loading
    case displayWeatherInfo(weatherResult: WeatherResult)
    case error(title: String, message: String)
}

/**
 Implementation for Equatable protocol
 */
extension MainViewState : Equatable {
    static func == (lhs: MainViewState, rhs: MainViewState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading): return true
        case (.displayWeatherInfo(let weatherResult), .displayWeatherInfo(let weatherResult2)):
            return true // IMPROVEMENT: Compare the two objects to check if they are the same !
            // return (weatherResult == weatherResult2) ? true : false
        case (.error(let title, let message), .error(let title2, let message2)):
            if title == title2 && message == message2 {
                return true
            } else {
                return false
            }
        default:
            return false
        }
    }
}
