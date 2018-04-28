//
//  RealmRepo.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 27/04/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import RxSwift
import RxRealm

/**
 Function used to terminate the app in case it is called. It is mainly used to report a developer a programming error such as: "you should override this function".
 - Returns: Never, a type with no values
 */
func abstractMethod() -> Never {
    fatalError("abstract method")
}

/**
 AbstractRepository<T>
 
 Abstract class used to list the functions that should be implemented by the class working as a Repository in the app. This allow us to be able to uncouple the repository layer from the others such as Interactor, Presentation, ...
 */
class AbstractRepository<T> {
    
    /**
     Function whose main purpose should be to return all the rows of an specific table. If this function is not overriden by the Repository class implementing this abstract class, a fatal error is thrown.
     - Returns: An Observable with an array of objects of type 'T'.
     */
    func queryAll() -> Observable<[T]> {
        abstractMethod()
    }
    
    /**
     Function whose main purpose should be to return the rows of an specific table that meet the conditions presented. If this function is not overriden by the Repository class implementing this abstract class, a fatal error is thrown.
     - Parameter predicate: conditions to be met by the rows that are returned
     - Parameter sortDescriptors: the sorting strategy to follow
     - Returns: An Observable with an array of objects of type 'T'.
     */
    func query(with predicate: String,
               sortDescriptors: [NSSortDescriptor] = []) -> Observable<[T]> {
        abstractMethod()
    }
    
    /**
     Function whose main purpose should be to return the rows of an specific table that meet the conditions presented. If this function is not overriden by the Repository class implementing this abstract class, a fatal error is thrown.
     - Parameter predicate: conditions to be met by the rows that are returned
     - Parameter startDate: starting date range
     - Parameter endDate: ending date range
     - Returns: An Observable with an array of objects of type 'T'.
     */
    func query(predicate: String, from startDate: Date, to endDate: Date) -> Observable<[T]> {
        abstractMethod()
    }
    
    /**
     Function whose main purpose should be to return the only (or first) row of the selected table. If this function is not overriden by the Repository class implementing this abstract class, a fatal error is thrown.
     - Returns: An Observable with an object of type 'T'.
     */
    func query() -> Observable<T> {
        abstractMethod()
    }
    
    /**
     Function whose main purpose should be to return the first row of an specific table that meet the conditions presented. If this function is not overriden by the Repository class implementing this abstract class, a fatal error is thrown.
     - Parameter predicate: conditions to be met by the rows that are returned
     - Returns: An Observable with an object of type 'T'.
     */
    func query(with predicate: String) -> Observable<T> {
        abstractMethod()
    }
    
    /**
     Function whose main purpose should be to save an entity in the local database. If this function is not overriden by the Repository class implementing this abstract class, a fatal error is thrown.
     - Parameter entity: the object that should be stored in the local database
     - Returns: An Observable<Void> working as a Completable
     */
    func save(entity: T) -> Observable<Void> {
        abstractMethod()
    }
    
    /**
     Function whose main purpose should be to delete an existing entity belonging to the local database. If this function is not overriden by the Repository class implementing this abstract class, a fatal error is thrown.
     - Parameter entity: the object that should be removed from the local database
     - Returns: An Observable<Void> working as a Completable
     */
    func delete(entity: T) -> Observable<Void> {
        abstractMethod()
    }
    
    /**
     Function whose main purpose should be to delete all the existing rows of the selected table belonging to the local database. If this function is not overriden by the Repository class implementing this abstract class, a fatal error is thrown.
     - Returns: An Observable<Void> working as a Completable
     */
    func deleteAll() -> Observable<Void> {
        abstractMethod()
    }
}

/**
 RealmRepo
 
 Implementation of a table in the local database using Realm technology. It must implement all the functions listed by the abstract class AbstractRepository and, if this requirement is not met, a fatal error is thrown. The type class "T" represents the type of entities that are stored in this table.
 */
final class RealmRepo<T:RealmRepresentable>: AbstractRepository<T> where T == T.RealmType.DomainType, T.RealmType: Object {
    
    /// Configuration realm property describing the different options used to create an instance of a Realm DB.
    private let configuration: Realm.Configuration
    /// Represents an object responisble for scheduling units of work, in this case database requests
    private let scheduler: RunLoopThreadScheduler
    
    /// The Realm instance (also referred to as “a Realm”) representing a local Realm database.
    private var realm: Realm {
        return try! Realm(configuration: self.configuration) // swiftlint:disable:this force_try
    }
    
    /**
     Initialization method for the RealmRepo class
     - Parameter configuration: the Realm configuration describing the different options to create an instance of a Realm DB. If not set, the default value is taken.
     */
    init(configuration: Realm.Configuration = Realm.Configuration()) {
        self.configuration = configuration
        let name = Constants.AppInfo.realmRepoName
        self.scheduler = RunLoopThreadScheduler(threadName: name)
        #if DEBUG
        print("File 📁 url for the class \(type(of: T.self)): \(RLMRealmPathForFile("default.realm"))")
        #endif
    }
    
    /**
     Function whose main purpose is to return all the rows of an specific table.
     - Returns: An Observable with an array of objects of type 'T'.
     */
    override func queryAll() -> Observable<[T]> {
        return Observable.deferred {
            let realm = self.realm
            let objects = realm.objects(T.RealmType.self)
            
            return Observable.array(from: objects)
                .mapToDomain()
            }
            .subscribeOn(scheduler)
    }
    
    /**
     Function whose main purpose is to return the rows of an specific table that meet the conditions presented.
     - Parameter predicate: conditions to be met by the rows that are returned
     - Parameter sortDescriptors: the sorting strategy to follow
     - Returns: An Observable with an array of objects of type 'T'.
     */
    override func query(with predicate: String,
                        sortDescriptors: [NSSortDescriptor] = []) -> Observable<[T]> {
        return Observable.deferred {
            let realm = self.realm
            let objects = realm.objects(T.RealmType.self).filter(predicate)
            
            return Observable.array(from: objects)
                .mapToDomain()
            }
            .subscribeOn(scheduler)
    }
    
    /**
     Function whose main purpose should be to return the rows of an specific table that meet the conditions presented.
     - Parameter predicate: conditions to be met by the rows that are returned
     - Parameter startDate: starting date range
     - Parameter endDate: ending date range
     - Returns: An Observable with an array of objects of type 'T'.
     */
    override func query(predicate: String, from startDate: Date, to endDate: Date) -> Observable<[T]> {
        return Observable.deferred {
            let realm = self.realm
            let objects = realm.objects(T.RealmType.self).filter(predicate, startDate, endDate)
            
            return Observable.array(from: objects)
                .mapToDomain()
            }
            .subscribeOn(scheduler)
    }
    
    /**
     Function whose main purpose is to return the only (or first) row of the selected table.
     - Returns: An Observable with an object of type 'T'.
     */
    override func query() -> Observable<T> {
        return Observable.create { observer in
            let realm = self.realm
            let objects = realm.objects(T.RealmType.self)
            let object = objects.first?.asDomain()
            if let object = object {
                observer.on(.next(object))
            }
            observer.on(.completed)
            return Disposables.create()
            }
            .subscribeOn(scheduler)
    }
    
    /**
     Function whose main purpose is to return the first row of an specific table that meet the conditions presented.
     - Parameter predicate: conditions to be met by the rows that are returned
     - Returns: An Observable with an object of type 'T'.
     */
    override func query(with predicate: String) -> Observable<T> {
        return Observable.create { observer in
            let realm = self.realm
            let objects = realm.objects(T.RealmType.self).filter(predicate)
            let object = objects.first?.asDomain()
            if let object = object {
                observer.on(.next(object))
            }
            observer.on(.completed)
            return Disposables.create()
            }
            .subscribeOn(scheduler)
    }
    
    /**
     Function whose main purpose is to save an entity in the local database.
     - Parameter entity: the object that should be stored in the local database
     - Returns: An Observable<Void> working as a Completable
     */
    override func save(entity: T) -> Observable<Void> {
        return Observable.deferred {
            let realm = self.realm
            return realm.rx.save(entity: entity)
            }.subscribeOn(scheduler)
    }
    
    /**
     Function whose main purpose is to delete an existing entity belonging to the local database.
     - Parameter entity: the object that should be removed from the local database
     - Returns: An Observable<Void> working as a Completable
     */
    override func delete(entity: T) -> Observable<Void> {
        return Observable.deferred {
            return self.realm.rx.delete(entity: entity)
            }
            .subscribeOn(scheduler)
    }
    
    /**
     Function whose main purpose is to delete all the existing rows of the selected table belonging to the local database.
     - Returns: An Observable<Void> working as a Completable
     */
    override func deleteAll() -> Observable<Void> {
        return Observable.create { observer in
            let realm = self.realm
            try! realm.write { // swiftlint:disable:this force_try
                realm.delete(realm.objects(T.RealmType.self))
            }
            observer.on(.completed)
            return Disposables.create()
            }
            .subscribeOn(scheduler)
    }
}
