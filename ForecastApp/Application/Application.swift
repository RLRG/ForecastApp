//
//  Application.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 27/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import RxSwift
import UIKit

/**
 Application
 
 Object-singleton responsible for connecting all the layers of the app taking into account that we are following an architecture very similar to VIPER (View, Interactor, Presenter, Entity, Routing) using reactive programming technologies (RxSwift).
 */
final class Application {
    
    // MARK: - SINGLETON
    
    /// The reference to the object-singleton
    static let shared = Application()
    
    // MARK: - Properties & Initialization
    
    /// The abstraction layer of the data repository
    var repository : Repository!
    /// The abstraction layer of the Interactor.
    var useCaseProvider : UseCaseProvider!
    
    
    // MARK: - Clean Architecture Logic
    
    /**
     Start the app by creating the data repository and interactor layers
     - Parameter mainWindow: The UIWindow in which the app is framed. Cannot be empty
     */
    func startApp(mainWindow: UIWindow) {
        let realmConfig = getRealmMigrationConfig()
        repository = Repository(serverProvider: ServerProvider(),
                                weatherResultsRepo: RealmRepo<WeatherResult>(configuration: realmConfig),
                                locationsRepo: RealmRepo<Location>(configuration: realmConfig),
                                citiesRepo: RealmRepo<City>(configuration: realmConfig),
                                weatherRangesRepo: RealmRepo<WeatherRange>(configuration: realmConfig),
                                userDefaults: UserDefaults.standard)
        useCaseProvider = UseCaseProvider(with: repository)
        
        mainWindow.rootViewController = cleanArchitectureConfiguration()
        mainWindow.makeKeyAndVisible()
    }
    
    /**
     Manage the realm local database migrations. This function will gain importance when the app is released to the public since we'll probably need to change the local database model and, also, need to manage the migrations here. For further information on how to migrate, please, refer to: https://realm.io/docs/swift/latest/#migrations
     - Returns: the realm configuration to be applied to the local DB
     */
    func getRealmMigrationConfig() -> Realm.Configuration {
        return Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used version (when you've never set a schema version before, the version is 0).
            schemaVersion: 1,
            
            // Set the block which will be called automatically when opening a Realm with a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in //swiftlint:disable:this unused_closure_parameter
                // When we hadn't migrated anything yet, oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do for now !
                    // Realm will automatically detect new properties and removed properties and will update the schema on disk automatically
                }
        })
    }
    
    /**
     Connect the layers of the app (VIPER) for the main screen of the app
     - Returns: The main navigation controller
     */
    func cleanArchitectureConfiguration() -> UINavigationController {
        let storyboardName = Constants.Storyboard.Main
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let navController = storyboard.instantiateInitialViewController() as! UINavigationController // swiftlint:disable:this force_cast
        let mainVC = navController.topViewController as! MainVC // swiftlint:disable:this force_cast
        let searchWeatherUseCase = useCaseProvider.makeSearchWeatherUseCase()
        let mainPresenter = MainPresenter(getWeatherForecastUseCase: searchWeatherUseCase)
        mainVC.presenter = mainPresenter
        
        return navController
    }
}
