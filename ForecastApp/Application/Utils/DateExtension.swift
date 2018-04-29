//
//  DateExtension.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 29/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation

/**
 Date extension
*/
extension Date {
    
    /**
     Date to be displayed in the main screen
     - Paramater start: starting date
     - Returns: the UI dates to be displayed
     */
    static func dateToDateString(start: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "HH:mm"
        let startDateString = dateFormatter.string(from: start)
        let endDate = start.addingTimeInterval(180*60) // Each timeframe lasts 3 hours (180 min * 60 segs).
        let endDateString = dateFormatter.string(from: endDate)
        return "\(startDateString) - \(endDateString)"
    }
}
