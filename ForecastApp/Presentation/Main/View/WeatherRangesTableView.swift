//
//  WeatherRangesTableView.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 29/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Table View delegate

// MARK: - Table View data source

/**
 This MainVC extension helps to populate the weatherTableView in the main screen.
 */
extension MainVC: UITableViewDataSource {
    
    /**
     Tells the data source to return the number of rows in a given section of a table view
     - Parameter tableView: table view object requesting the information
     - Parameter section: index number identifying a section in tableView
     - Returns: number of rows in section
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let weatherResult = currentWeatherResult else {
            return 0
        }
        return weatherResult.weatherRanges.count
    }
    
    /**
     Asks the data source for a cell to insert in a particular location of the table view
     - Parameter tableView: table view object requesting the cell
     - Parameter indexPath: index path locating a row in tableView
     - Returns: object inheriting from UITableViewCell that the table view can use for the specified row
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCell.WeatherRangeCell, for: indexPath) // Get the empty cell.
        self.presenter.configure(cell: cell as! WeatherRangeCell, forRowAt: indexPath.row) // swiftlint:disable:this force_cast
        return cell
    }
}
