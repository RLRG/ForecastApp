//
//  MainViewController.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 27/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import UIKit
import RxSwift
import CoreLocation
import SVProgressHUD
#if ForecastAppLAB
    import FLEX
#endif

/**
 MainVC
 
 This ViewController is the main screen to be presented in the app whose main purpose is to display the received weather forecast information.
 */
class MainVC: UIViewController {
    
    // MARK: - Properties & Initialization
    
    /// Reference to the presenter layer
    public var presenter: MainPresenter!
    /// Bag to dispose added disposables
    private let disposeBag = DisposeBag()
    
    /// UIBarButtonItem used to display the in-app debugger
    @IBOutlet weak var debuggerButton: UIBarButtonItem!
    /// UIBarButtonItem used to refresh the weather information
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    /// The name of the current city
    @IBOutlet weak var cityLabel: UILabel!
    /// The average temperature for the current city/timeframe
    @IBOutlet weak var mainTemperatureLabel: UILabel!
    /// The current or the last updated timeframe
    @IBOutlet weak var mainTimeframeLabel: UILabel!
    /// The icon weather for the current city/timeframe
    @IBOutlet weak var mainIconWeather: UIImageView!
    /// The max temperature for the current city/timeframe
    @IBOutlet weak var mainTemperatureMax: UILabel!
    /// The min temperature for the current city/timeframe
    @IBOutlet weak var mainTemperatureMin: UILabel!
    
    /// Table view to display the WeatherRanges
    @IBOutlet weak var weatherTableView: UITableView!
    
    /// LocationManager property responsible for getting the current location
    var locationManager: CLLocationManager?
    /// The last location received from the LocationManager, ie., the current location
    var lastLocation: CLLocation?
    
    /// The last weather forecast data to be shown.
    var currentWeatherResult: WeatherResult?
    
    /**
     Lifecycle method called when the object is initializing
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // LocationManager config
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.requestWhenInUseAuthorization()
            locationManager?.startUpdatingLocation()
        }
        
        // Set data source for the tableView
        self.weatherTableView.dataSource = self
        
        // In-App Debugger
        #if car_sharing_remourbanLAB
            debuggerButton.isEnabled = true
        #else
            debuggerButton.isEnabled = false
        #endif
        
        setupViewStateObserver()
    }
    
    /**
     Display the FLEX in-app debugger when the target "ForecastAppLAB" is running
     - Parameter sender: The UIBarButtonItem caller of the action
    */
    @IBAction func showFLEXDebugger(_ sender: UIBarButtonItem) {
        #if car_sharing_remourbanLAB
            FLEXManager.shared().showExplorer()
        #endif
    }
    
    /**
     This UIViewController subscribes to the mainViewStateObservable to get the current view state and display it
     */
    func setupViewStateObserver() {
        presenter.mainViewStateObservable
            .subscribe(
                onNext: { viewState in
                    DispatchQueue.main.async {
                        switch (viewState) {
                        case .loading:
                            self.displayLoadingView()
                        case .displayWeatherInfo(let weatherResult):
                            self.currentWeatherResult = weatherResult
                            self.updateUI()
                        case .error(let title, let message):
                            self.displayError(with: title, and: message)
                        }
                    }
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - UI Logic (Presenter -> UIViewController)
    
    /**
     Let the user know that an operation is loading in the app
     */
    func displayLoadingView() {
        SVProgressHUD.setDefaultAnimationType(.native)
        SVProgressHUD.setBackgroundColor(UIColor.darkGray)
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.show()
    }
    
    /**
     Responsible for updating the User Interface to show the weather forecast info to the user.
    */
    func updateUI() {
        SVProgressHUD.dismiss()
        if let weather = self.currentWeatherResult {
            // Main info
            cityLabel.text = weather.city.name
            mainTemperatureLabel.text = String(format: "%.1f", weather.weatherRanges[0].temperatureAverage) + " ºC"
            mainTimeframeLabel.text = Date.dateToDateString(start: weather.weatherRanges[0].startingTime)
            mainIconWeather.image = UIImage(named: weather.weatherRanges[0].weatherIcon)
            mainTemperatureMax.text = String(format: "%.1f", weather.weatherRanges[0].temperatureMax)
            mainTemperatureMin.text = String(format: "%.1f", weather.weatherRanges[0].temperatureMin)
            
            // TableView
            self.weatherTableView.reloadData()
        }
    }
    
    /**
     Let the user know that an error has ocurred during the course of an operation
     - Parameter title: title for error message
     - Parameter message: error message inside the view
     */
    func displayError(with title: String, and message: String) {
        SVProgressHUD.dismiss()
        AlertsManager.alert(caller: self, message: message, title: title) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    // MARK: - Actions (UIViewController -> Presenter)
    
    /**
     Refresh button action allowing to get updated information about the weather forecast.
     - Parameter sender: refresh bar button
    */
    @IBAction func refreshAction(_ sender: UIBarButtonItem) {
        if let lat = lastLocation?.coordinate.latitude,
            let lon = lastLocation?.coordinate.longitude {
            presenter.getWeatherForecastForCurrentLocation(withLat: lat, withLon: lon)
        } else {
            presenter.displayError(with: UIMessages.errorLocationServicesTitle, and: UIMessages.errorLocationServices)
        }
    }
    
}
