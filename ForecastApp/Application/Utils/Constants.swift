//
//  Constants.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 27/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation

/**
 Constants
 
 It contains the constant values used in the main production code.
 */
struct Constants {
    
    /**
     This struct includes general info about the app
    */
    struct AppInfo {
        /// The main name for the Realm repository.
        static let realmRepoName = "com.CleanArchitectureRxSwift.RealmRepo"
    }
    
    /**
     This struct includes labels for buttons
    */
    struct Button {
        /// Label for "OK" button
        static let OK = "OK"
    }
    
    /**
     This struct includes identifiers for the cells used in tableViews.
    */
    struct TableViewCell {
        /// Identifier for the WeatherCell used in the main screen
        static let WeatherRangeCell = "WeatherRangeCell"
    }
    
    /**
     This struct includes identifiers for the storyboards of the project.
    */
    struct Storyboard {
        /// Identifier for the Main storyboard of the app.
        static let Main = "Main"
    }
}
