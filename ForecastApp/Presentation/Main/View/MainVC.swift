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
import Wit

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
    @IBOutlet weak var debuggerButton: UIButton!
    /// UIBarButtonItem used to refresh the weather information
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    /// The name of the current city
    @IBOutlet weak var cityLabel: UILabel!
    /// Label indicating the last time we could update the information from the server.
    @IBOutlet weak var updatedTimeLabel: UILabel!
    /// The average temperature for the current city/timeframe
    @IBOutlet weak var mainTemperatureLabel: UILabel!
    /// The current or the last updated timeframe
    @IBOutlet weak var mainTimeframeLabel: UILabel!
    /// The icon weather for the current city/timeframe
    @IBOutlet weak var mainIconWeather: UIImageView!
    /// The speed of the wind (m/s) label
    @IBOutlet weak var mainWindSpeed: UILabel!
    /// The raining probability percentage
    @IBOutlet weak var mainPrecipitationPercent: UILabel!
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
    /// Flag used to make the first data request only.
    var isFirstOpen: Bool = true
    
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
        
        // WIT AI config
        Wit.sharedInstance().delegate = self
        let screen: CGRect = UIScreen.main.bounds
        let rect = CGRect(x: (screen.size.width/2 + 100), y:100, width:50, height:50) // IMPROVEMENT: Set up the position for all the possible iPhone/iPad screens appropriately and not this way. This is optimized only for iPhone X for now.
        let witButton = WITMicButton(frame: rect)
        self.view.addSubview(witButton)
        
        // Set data source for the tableView
        self.weatherTableView.dataSource = self
        
        // Initialize the flag to request the data with the first GPS location
        self.isFirstOpen = true
        
        // In-App Debugger
        #if ForecastAppLAB
            debuggerButton.isHidden = false
        #else
            debuggerButton.isHidden = true
        #endif
        
        setupViewStateObserver()
    }
    
    /**
     Display the FLEX in-app debugger when the target "ForecastAppLAB" is running
     - Parameter sender: The UIBarButtonItem caller of the action
    */
    @IBAction func showFLEXDebugger(_ sender: UIButton) {
        #if ForecastAppLAB
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
            updatedTimeLabel.text = Date.updatedDateToDateString(date: weather.city.timeRequested)
            mainTemperatureLabel.text = String(format: "%.1f", weather.weatherRanges[0].temperatureAverage) + " ºC"
            mainTimeframeLabel.text = Date.dateToDateString(start: weather.weatherRanges[0].startingTime)
            mainIconWeather.image = UIImage(named: weather.weatherRanges[0].weatherIcon)
            mainWindSpeed.text = String(format: "%.1f", weather.weatherRanges[0].windSpeed) + "m/s"
            if (weather.weatherRanges[0].precipitation != 0) {
                mainPrecipitationPercent.text = String(weather.weatherRanges[0].precipitation) + "%"
            } else {
                mainPrecipitationPercent.text = ""
            }
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
    
    /**
     This function will allow in the future to request the weather forecast by asking the name of a city to the user, not just the current location of the iphone.
     - Parameter sender: The button sending the action, in this case: the "Add" button.
    */
    @IBAction func searchWeatherForAnotherCity(_ sender: UIBarButtonItem) {
        AlertsManager.alert(caller: self, message: "The idea for this button would be to be able to display a small screen asking for the name of the city and request the weather forecast for that city. This will be done in a future version", title: "WARNING") {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
