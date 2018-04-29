//
//  UIMessages.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 27/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation

/**
 UIMessages
 
 It contains the messages being displayed to the user of the app.
 */
struct UIMessages {
    
    // MARK: - General
    
    static let errorGeneralTitle = NSLocalizedString("Error", comment: "")
    static let errorGeneral = NSLocalizedString("It has not been possible to update the Weather information. Please, check if you have Internet connection and try again.", comment: "")
    
    static let errorLocationServicesTitle = NSLocalizedString("Operation location error", comment: "")
    static let errorLocationServices = NSLocalizedString("Please, check that you have allowed your location services and try again", comment: "")
}
