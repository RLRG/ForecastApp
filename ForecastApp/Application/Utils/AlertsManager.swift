//
//  AlertsManager.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 29/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation
import UIKit

/**
 Class responsible for creating system alerts to be displayed to the user
 */
class AlertsManager {
    
    /**
     Create a system default alert with an "OK" option to dismiss the alert
     - Parameter caller: the ViewController which wants to display a new alert.
     - Parameter message: the main message to be displayed to the user
     - Parameter okActionHandler: the actions that should be carried out after the alert is dismissed.
    */
    class func alert(caller: UIViewController, message: String, title: String = "", okActionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: Constants.Button.OK, style: .default) { _ in
            okActionHandler()
        }
        alertController.addAction(OKAction)
        DispatchQueue.main.async {
            caller.present(alertController, animated: true, completion: nil)
        }
    }
}
