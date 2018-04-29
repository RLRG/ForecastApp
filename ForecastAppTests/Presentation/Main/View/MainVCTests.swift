//
//  MainVCTests.swift
//  ForecastAppTests
//
//  Created by Rodrigo López-Romero Guijarro on 27/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation
import XCTest
import RxSwift
import CoreLocation

@testable import ForecastApp

class MainVCTests: XCTestCase {
    
    // MARK: - CONFIGURATION
    
    var sut: MainVC! // System Under Test: ViewController !!
    var presenter: TestableMainPresenter!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: Constants.Storyboard.Main, bundle: nil)
        let navController = storyboard.instantiateInitialViewController() as! UINavigationController
        sut = navController.topViewController as! MainVC
        presenter = TestableMainPresenter(getWeatherForecastUseCase: TestableSearchWeatherUseCase())
        sut.presenter = presenter
        
        // sut.viewDidLoad() <<<<<<<<<<------- DON'T DO THIS !!!! WHAT WE SHOULD DO IS:
        _ = sut.view
    }
    
    override func tearDown() {
        sut = nil
        presenter = nil
        super.tearDown()
    }
    
    func testTrueTest() {
        XCTAssertTrue(true)
    }
    
    // MARK: - TESTS
    
    func testFirstOpenIsTrueWhenViewDidLoad() {
        XCTAssertTrue(sut.isFirstOpen)
    }

    func testRefreshButtonInvokesUseCaseSuccess() {
        sut.lastLocation = CLLocation(latitude: TestData.location.lat, longitude: TestData.location.lon)
        let refreshButton = sut.refreshButton
        sut.refreshAction(refreshButton!)
        XCTAssertTrue(presenter.getWeatherForecastForCurrentLocationInvoked)
    }
    
    func testRefreshButtonInvokesUseCaseNoLocation() {
        sut.lastLocation = nil
        let refreshButton = sut.refreshButton
        sut.refreshAction(refreshButton!)
        XCTAssertFalse(presenter.getWeatherForecastForCurrentLocationInvoked)
        XCTAssertTrue(presenter.displayErrorInvoked)
    }
    
    // MARK: - MOCKS
    
    class TestableMainPresenter: MainPresenter {
        var getWeatherForecastForCurrentLocationInvoked = false
        override func getWeatherForecastForCurrentLocation(withLat lat: Double, withLon lon: Double) {
            getWeatherForecastForCurrentLocationInvoked = true
        }
        
        var displayErrorInvoked = false
        override func displayError(with title: String, and message: String) {
            displayErrorInvoked = true
        }
    }
    
    class TestableSearchWeatherUseCase : SearchWeatherProtocol {
        func getWeatherForecast(withName name: String?, withLat lat: Double, withLon lon: Double) -> Observable<WeatherResult> {
            return Observable<WeatherResult>.create({ (observer) -> Disposable in
                observer.onCompleted()
                return Disposables.create()
            })
        }
        
    }
}
