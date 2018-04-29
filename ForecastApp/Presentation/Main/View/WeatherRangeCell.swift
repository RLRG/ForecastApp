//
//  WeatherRangeCell.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 29/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import UIKit

/**
 WeatherRangeCell
 
 UITableViewCell setup and configuration
 */
class WeatherRangeCell: UITableViewCell {
    /// The time label used to display the timeframe for that weatherResult
    @IBOutlet weak var timeLabel: UILabel!
    /// The weather icon to display
    @IBOutlet weak var weatherIcon: UIImageView!
    /// The wind speed (m/s) label
    @IBOutlet weak var windSpeed: UILabel!
    /// The raining probability label
    @IBOutlet weak var precipitationChance: UILabel!
    /// The maximum temperature
    @IBOutlet weak var temperatureMax: UILabel!
    /// The minimum temperature
    @IBOutlet weak var temperatureMin: UILabel!
}

// MARK: - WeatherRangeCellProtocol
extension WeatherRangeCell : WeatherRangeCellProtocol {
    
    /**
     Displays configured cell
     - Parameter weatherRange: the information to be displayed in each cell
     */
    func display(weatherRange: WeatherRange) {
        self.timeLabel.text = Date.dateToDateString(start: weatherRange.startingTime)
        self.weatherIcon.image = UIImage(named: weatherRange.weatherIcon)
        self.windSpeed.text = String(weatherRange.windSpeed) + "m/s"
        if (weatherRange.precipitation != 0) {
            self.precipitationChance.text = String(weatherRange.precipitation) + "%"
        } else {
            self.precipitationChance.text = ""
        }
        self.temperatureMax.text = String(format: "%.1f", weatherRange.temperatureMax)
        self.temperatureMin.text = String(format: "%.1f", weatherRange.temperatureMin)
    }
}
