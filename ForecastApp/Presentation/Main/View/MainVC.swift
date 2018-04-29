//
//  MainViewController.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 27/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import UIKit
import RxSwift
import SVProgressHUD
#if ForecastAppLAB
    import FLEX
#endif

/**
 MainVC
 
 TODO: Description
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
    
    /// TODO: Description
    var currentWeatherResult: WeatherResult?
    
    /**
     Lifecycle method called when the object is initializing
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // In-App Debugger
        #if car_sharing_remourbanLAB
            debuggerButton.isEnabled = true
        #else
            debuggerButton.isEnabled = false
        #endif
        
        setupViewStateObserver()
        presenter.viewIsReady()
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
        SVProgressHUD.setBackgroundColor(UIColor.purple)
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.show()
    }
    
    /**
     TODO: Description
    */
    func updateUI() {
        SVProgressHUD.dismiss()
        // TODO: updateWeatherInfo() !!
        print("TODO: updateWeatherInfo(weatherResult: WeatherResult) !!")
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
     TODO: Description
     - Parameter sender:
    */
    @IBAction func refreshAction(_ sender: UIBarButtonItem) {
        presenter.getWeatherForecast()
    }
    
}
