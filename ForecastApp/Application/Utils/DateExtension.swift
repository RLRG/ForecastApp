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
     - Returns: the UI date to be displayed
     */
    static func dateToDateString(start: Date) -> String {
        // Times
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "HH"
        
        // Week day
        let f = DateFormatter()
        let weekDay = f.shortWeekdaySymbols[Calendar.current.component(.weekday, from: start)]
        
        // Result
        let startDateString = dateFormatter.string(from: start)
        let endDate = start.addingTimeInterval(180*60) // Each timeframe lasts 3 hours (180 min * 60 segs).
        let endDateString = dateFormatter.string(from: endDate)
        return "\(weekDay) \(startDateString)-\(endDateString)"
    }
    
    /**
     Date to be displayed in the main screen indicating the last update from the server data.
     - Paramater date: the date when the data was updated.
     - Returns: the UI date to be displayed
     */
    static func updatedDateToDateString(date: Date) -> String {
        // Times
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "HH:mm"
        
        // Week day
        var weekDay = ""
        if Calendar.current.isDate(date, inSameDayAs:Date()) {
            weekDay = "Today"
        } else {
            let f = DateFormatter()
            weekDay = f.shortWeekdaySymbols[Calendar.current.component(.weekday, from: date)]
        }
        
        // Result
        let dateString = dateFormatter.string(from: date)
        return "\(weekDay) \(dateString)"
    }
}
