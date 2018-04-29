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
     TODO: Description
    */
    struct TableViewCell {
        /// TODO: Description
        static let WeatherRangeCell = "WeatherRangeCell"
    }
}
