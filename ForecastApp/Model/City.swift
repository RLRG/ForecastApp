//
//  City.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 27/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation

/**
 City
 
 Model/Logic entity which contains the name of the city and the last time requested.
 */
public struct City {
    let name: String
    let timeRequested: Date
}
