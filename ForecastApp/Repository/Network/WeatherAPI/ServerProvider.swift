//
//  ServerProvider.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 27/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation
import RxSwift

/**
 ServerProvider
 
 The class providing the calls to the web services offered by the main endpoint server of the system. It conforms the ServerProviderProtocol.
 */
class ServerProvider : ServerProviderProtocol {
    
    // MARK: - Properties & Initialization
    
    /// The IP/URL identifier of the server from the one the data is obtained
    private let apiEndpoint: String
    /// Bag to dispose added disposables [RxSwift]
    private let disposeBag = DisposeBag()
    
    /**
     Initialization method for the ServerProvider class
     */
    public init() {
        apiEndpoint = API.endpoint
    }
    
    // MARK: - Weather API
    
    func getWeatherForecast(withName name: String?, withLat lat: Double, withLon lon: Double) -> Observable<WeatherResult> {
        return Observable<WeatherResult>.create({ (observer) -> Disposable in
            // TODO: getWeatherForecast()
            observer.onCompleted()
            return Disposables.create()
        })
    }
    
}
