//
//  WeatherRangeCellProtocol.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 29/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import UIKit

/**
 WeatherRangeCellProtocol
 
 Protocol used to present each cell. We do not want to include the logic in the view.
 */
protocol WeatherRangeCellProtocol {
    /**
     Displays configured cell
     - Parameter weatherRange: the information to be displayed in each cell
     */
    func display(weatherRange: WeatherRange)
}
