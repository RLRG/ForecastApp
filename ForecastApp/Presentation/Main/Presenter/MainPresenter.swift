//
//  MainPresenter.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 27/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation
import RxSwift

/**
 MainPresenter
 
 Object responsible for providing the weather forecast to the view, telling the view what to display and when. It contains all the logic of the main screen.
 
 This class behaves as the manager of a states machine of the UIViewController. The possible view states can be found in the class "MainViewState"
 */
class MainPresenter {
    
    // MARK: - Properties & Initialization
    
    /// Rx PublishSubject responsible for sending the events from the presenter to the UIViewController - MainVC
    private var mainViewState : PublishSubject<MainViewState> = PublishSubject<MainViewState>()
    /// Rx PublishSubject observable to the one the UIViewController - MainVC is attached to get the all the possible states
    var mainViewStateObservable : Observable<MainViewState> {
        return mainViewState.asObservable()
    }
    /// The current ViewState of the UIViewController attached - MainVC
    private var currentViewState : MainViewState
    /// WeatherResult object which is sent to the view to be displayed
    private var currentWeatherResult: WeatherResult?
    /// SearchWeather use case abstraction - Interactor - used to get the weather data
    private let getWeatherForecastUseCase: SearchWeatherProtocol
    /// Bag to dispose added disposables [RxSwift]
    private let disposeBag = DisposeBag()
    
    /**
     Initialization method for the MainPresenter class
     - Parameter getUserProfileUseCase: The interactor layer to call the getUserProfile functionality
     - Parameter saveUserProfileUseCase: The interactor layer to call the saveUserProfile functionality
     - Parameter logoutUseCase: The interactor layer to call the logout functionality
     */
    init(getWeatherForecastUseCase: SearchWeatherProtocol) {
        self.getWeatherForecastUseCase = getWeatherForecastUseCase
        
        // Set the default viewState to "loading"
        currentViewState = MainViewState.loading
    }
    
    // MARK: - Logic
    
    /**
     Call the SearchWeather use case to get the weather forecast data. If it succeeds, the presenter sets the UIViewController to the "displayWeatherInfo" state. If it does not succeed, the presenter tells the UIViewController that an error must be displayed
     */
    func getWeatherForecast(for cityName: String) {
        self.currentViewState = MainViewState.loading
        self.mainViewState.onNext(self.currentViewState)
        
        getWeatherForecastUseCase
            .getWeatherForecast(withName: cityName, withLat: 0.0, withLon: 0.0)
            .subscribe(
                onNext: { weatherResult in
                    self.currentWeatherResult = weatherResult
                    self.currentViewState = MainViewState.displayWeatherInfo(weatherResult: weatherResult)
                    self.mainViewState.onNext(self.currentViewState)
            },
                onError: { error in
                    self.displayError(with: UIMessages.errorGeneralTitle, and: UIMessages.errorGeneral)
            })
            .disposed(by: self.disposeBag)
    }
    
    /**
     Call the SearchWeather use case to get the weather forecast data. If it succeeds, the presenter sets the UIViewController to the "displayWeatherInfo" state. If it does not succeed, the presenter tells the UIViewController that an error must be displayed
     */
    func getWeatherForecastForCurrentLocation(withLat lat: Double, withLon lon: Double) {
        self.currentViewState = MainViewState.loading
        self.mainViewState.onNext(self.currentViewState)
        
        getWeatherForecastUseCase
            .getWeatherForecast(withName: nil, withLat: lat, withLon: lon)
            .subscribe(
                onNext: { weatherResult in
                    self.currentWeatherResult = weatherResult
                    self.currentViewState = MainViewState.displayWeatherInfo(weatherResult: weatherResult)
                    self.mainViewState.onNext(self.currentViewState)
            },
                onError: { error in
                    self.displayError(with: UIMessages.errorGeneralTitle, and: UIMessages.errorGeneral)
            })
            .disposed(by: self.disposeBag)
    }
    
    /**
     Configure weatherRange cells for WeatherRangesTableView
     - Parameter cell: the corresponding cell to be displayed in the UI
     - Parameter row: the row number to get the needed data
     */
    func configure(cell: WeatherRangeCell, forRowAt row: Int) {
        guard let weatherResult = self.currentWeatherResult else {
            return
        }
        let weatherRange = weatherResult.weatherRanges[row]
        cell.display(weatherRange: weatherRange)
    }
    
    /**
     Set the UIViewController to error state by displaying an error alert
     - Parameter title: the title for the error alert
     - Parameter message: the message to be displayed inside the error alert
     */
    func displayError(with title: String, and message: String) {
        self.currentViewState = MainViewState.error(title: title, message: message)
        self.mainViewState.onNext(self.currentViewState)
    }
}
