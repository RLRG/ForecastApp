//
//  MainPresenterTests.swift
//  ForecastAppTests
//
//  Created by Rodrigo López-Romero Guijarro on 27/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import XCTest
import RxSwift
import RxTest

@testable import ForecastApp

class MainPresenterTests: XCTestCase {
    
    // MARK: - CONFIGURATION
    
    var sut: MainPresenter!
    var viewStateObserver: TestableObserver<MainViewState>!
    var testSearchWeatherUseCase: TestableSearchWeatherUseCase!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        
        testSearchWeatherUseCase = TestableSearchWeatherUseCase()
        sut = MainPresenter(getWeatherForecastUseCase: testSearchWeatherUseCase)
        self.disposeBag = DisposeBag()
        
        scheduler = TestScheduler(initialClock: 0)
        viewStateObserver = scheduler.createObserver(MainViewState.self)
        sut.mainViewStateObservable.subscribe(self.viewStateObserver).disposed(by: disposeBag)
    }
    
    override func tearDown() {
        sut = nil
        viewStateObserver = nil
        testSearchWeatherUseCase = nil
        scheduler = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func testTrueTest() {
        XCTAssertTrue(true)
    }
    
    // MARK: - TESTS
    
    func testNoViewStateEventsYet() {
        scheduler.start()
        XCTAssertEqual(viewStateObserver.events.count, 0)
        XCTAssertEqual(viewStateObserver.events, [])
    }
    
    func testGetWeatherForecastSuccess() {
        scheduler.start()
        sut.getWeatherForecast(for: TestData.city.name)
        XCTAssertTrue(testSearchWeatherUseCase.searchWeatherInvoked)
        XCTAssertEqual(viewStateObserver.events[0].value.element!, MainViewState.loading)
        XCTAssertEqual(viewStateObserver.events[1].value.element!, MainViewState.displayWeatherInfo(weatherResult: TestData.weatherResult))
    }
    
    func testGetWeatherForecastError() {
        scheduler.start()
        testSearchWeatherUseCase.error = true
        sut.getWeatherForecast(for: TestData.city.name)
        XCTAssertTrue(testSearchWeatherUseCase.searchWeatherInvoked)
        XCTAssertEqual(viewStateObserver.events[0].value.element!, MainViewState.loading)
        XCTAssertEqual(viewStateObserver.events[1].value.element!, MainViewState.error(title: UIMessages.errorGeneralTitle, message: UIMessages.errorGeneral))
    }
    
    func testGetWeatherForecastForCurrentLocationSuccess() {
        scheduler.start()
        sut.getWeatherForecastForCurrentLocation(withLat: TestData.location.lat, withLon: TestData.location.lon)
        XCTAssertTrue(testSearchWeatherUseCase.searchWeatherInvoked)
        XCTAssertEqual(viewStateObserver.events[0].value.element!, MainViewState.loading)
        XCTAssertEqual(viewStateObserver.events[1].value.element!, MainViewState.displayWeatherInfo(weatherResult: TestData.weatherResult))
    }
    
    func testGetWeatherForecastForCurrentLocationError() {
        scheduler.start()
        testSearchWeatherUseCase.error = true
        sut.getWeatherForecastForCurrentLocation(withLat: TestData.location.lat, withLon: TestData.location.lon)
        XCTAssertTrue(testSearchWeatherUseCase.searchWeatherInvoked)
        XCTAssertEqual(viewStateObserver.events[0].value.element!, MainViewState.loading)
        XCTAssertEqual(viewStateObserver.events[1].value.element!, MainViewState.error(title: UIMessages.errorGeneralTitle, message: UIMessages.errorGeneral))
    }
    
    // MARK: - MOCKS
    
    class TestableSearchWeatherUseCase: SearchWeatherProtocol {
        var searchWeatherInvoked = false
        var error = false
        func getWeatherForecast(withName name: String?, withLat lat: Double, withLon lon: Double) -> Observable<WeatherResult> {
            searchWeatherInvoked = true
            return Observable<WeatherResult>.create { observer in
                if !self.error {
                    observer.onNext(TestData.weatherResult)
                    observer.onCompleted()
                } else {
                    observer.onError(NSError(domain: "Error when getting weather forecast data", code: -1, userInfo: nil))
                }
                return Disposables.create()
            }
        }
    }

}
