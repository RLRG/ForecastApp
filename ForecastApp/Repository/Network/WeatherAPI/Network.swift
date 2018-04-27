//
//  Network.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 27/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift
import ObjectMapper

/**
 Network
 
 This class provides the main networking functionality. It includes the main HTTP methods (GET, POST, PUT, DELETE...) adapted to our system.
 */
final class Network<T: ImmutableMappable> {
    
    // MARK: - Properties & Initialization
    
    /// The IP/URL identifier of the server from the one the data is obtained
    private let endPoint: String
    /// The scheduler on which the request will be enqueued
    private let scheduler: ConcurrentDispatchQueueScheduler
    
    /**
     Initialization method for the Network<T: ImmutableMappable> class
     - Parameter endPoint: IP/URL identifier of the server from the one the data is obtained
     */
    init(_ endPoint: String) {
        self.endPoint = API.endpoint
        self.scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
    }
    
    
    // MARK: - GET Request methods
    
    /**
     Run an HTTP request of type GET
     - Parameter path: it usually includes the specific web service we would like to call
     - Parameter jsonKey: if the json response is returned inside the main body of a 'root entity', this parameter should be used
     - Returns: An Observable with an object of type 'T'.
     */
    func getRequest(_ path: String, rootJSONEntity jsonKey: String) -> Observable<T> {
        let absolutePath = "\(endPoint)\(path)"
        return RxAlamofire
            .json(.get, absolutePath) // IMPROVEMENT: Refactor GET functions to improve efficiency here ! I'm sure it can be done !
            //.debug()
            .observeOn(scheduler)
            .map({ json -> T in
                var jsonData: [String : Any] = json as! [String : Any] // swiftlint:disable:this force_cast
                if jsonKey != "" {
                    jsonData = jsonData[jsonKey] as! [String : Any] // swiftlint:disable:this force_cast
                }
                return try Mapper<T>().map(JSONObject: jsonData)
            })
    }
    
    /**
     Run an HTTP request of type GET. It returns an array of the entity of type "T"
     - Parameter path: it usually includes the specific web service we would like to call
     - Parameter jsonKey: if the json response is returned inside the main body of a 'root entity', this parameter should be used
     - Returns: An Observable with an object of type '[T]'.
     */
    func getRequest(_ path: String, rootJSONEntity jsonKey: String) -> Observable<[T]> {
        let absolutePath = "\(endPoint)\(path)"
        return RxAlamofire
            .json(.get, absolutePath)
            //.debug()
            .observeOn(scheduler)
            .map({ json -> [T] in
                var jsonData: [String : Any] = json as! [String : Any] // swiftlint:disable:this force_cast
                if jsonKey != "" {
                    jsonData = jsonData[jsonKey] as! [String : Any] // swiftlint:disable:this force_cast
                }
                return try Mapper<T>().mapArray(JSONObject: jsonData)
            })
    }
    
    
    // MARK: - POST Request methods
    
    /**
     Run an HTTP request of type POST with the authentication header included
     - Parameter path: it usually includes the specific web service we would like to call
     - Parameter parameters: the content of the json body which is sent inside the request
     - Returns: An Observable with an object of type 'T'.
     */
    func postRequest(_ path: String, parameters: [String: Any]?) -> Observable<T> {
        let absolutePath = "\(endPoint)\(path)"
        return RxAlamofire
            .json(.post, absolutePath, parameters: parameters) // IMPROVEMENT: Refactor GET functions to improve efficiency here ! I'm sure it can be done !
            //.debug()
            .observeOn(scheduler)
            .map({ json -> T in
                return try Mapper<T>().map(JSONObject: json)
            })
    }
    
    
    // MARK: - PUT Request methods
    
    /**
     Run an HTTP request of type PUT
     - Parameter path: it usually includes the specific web service we would like to call
     - Parameter parameters: the content of the json body which is sent inside the request
     - Returns: An Observable with an object of type 'T'.
     */
    func putRequest(_ path: String, parameters: [String: Any]) -> Observable<T> {
        let absolutePath = "\(endPoint)/\(path)"
        return RxAlamofire
            .json(.put, absolutePath, parameters: parameters)
            //.debug()
            .observeOn(scheduler)
            .map({ json -> T in
                return try Mapper<T>().map(JSONObject: json)
            })
    }
    
    
    // MARK: - DELETE Request methods
    
    /**
     Run an HTTP request of type DELETE
     - Parameter path: it usually includes the specific web service we would like to call
     - Returns: An Observable with an object of type 'T'.
     */
    func deleteRequest(_ path: String) -> Observable<T> {
        let absolutePath = "\(endPoint)\(path)"
        return RxAlamofire
            .json(.delete, absolutePath)
            //.debug()
            .observeOn(scheduler)
            .map({ json -> T in
                return try Mapper<T>().map(JSONObject: json)
            })
    }
}
