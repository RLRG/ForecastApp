# ForecastApp

Repository an iOS weather Forecast app: ForecastApp.

This app was created to work on Clean Architecture, RxSwift and all the technologies listed in the table below.

## Objective and audience of the app
 The main functionality of the app is to display the weather forecast for the current user GPS location for the next 2/3 hours, containing the following data:
 * temperature
 * wind
 * precipitation
 Moreover, among others things, the user will be able to request the weather for other locations.

## 1. Build and install

### 1.1. Requirements
* Xcode 9.3
* iOS 10 SDK and above
* Swift 4

### 1.2. Getting the code
In order to build, run and access the app, the first thing you have to do is to clone the repository:
```
git clone https://github.com/RLRG/ForecastApp.git
```
It is important to remark that we have used CocoaPods as the dependency manager for this project so that it is needed to run a ‘pod install’ command in the same path where the PodFile is located to download all the third-party frameworks:
```
pod install
```

### 1.3. Running the app
Open `ForecastApp.xcworkspace` with XCode. Then, you are ready to go !

Before running it, note that there are two targets for now:
* ForecastAppLAB: When you run this target, you will see an extra button in order to open the FLEX in-app debugger, which is used to monitor and get information about the operation of the app in real time: logs, local database, network operation and so on.
* ForecastApp: This target would be used for the submission to the App Store.


## 2. Resources
This paragraph includes all the resources used to create this project, including frameworks, APIs and other information resources such as tutorials, documentation and so on.

### 2.1. Third-party frameworks
| Framework | Description |
| --- | --- |
| [CocoaPods](https://github.com/CocoaPods/CocoaPods) | The Cocoa Dependency Manager. |
| [FLEX Debugger](https://github.com/Flipboard/FLEX) | An in-app debugger. |
| [SwiftLint](https://github.com/realm/SwiftLint) | A tool to enforce Swift style and conventions. |
| [Alamofire](https://github.com/Alamofire/Alamofire) | Elegant HTTP Networking in Swift. |
| [Realm](https://github.com/realm/realm-cocoa) | Mobile database used to persist data of the app. |
| [RxSwift](https://github.com/ReactiveX/RxSwift) | Reactive Programming in Swift used mainly to communicate layers of the app. |
| Other | Other frameworks related to the ones already mentioned such as: RxRealm, RxTest, RxSwiftExt, RxAlamofire, ObjectMapper, QueryKit, RealmSwift (see project PodFile) |

### 2.2. APIs
| Framework | Description |
| --- | --- |
| [OpenWeather](https://openweathermap.org) | It is used to retrieve the information about the weather. |

### 2.3. Other information resources
| Resource | Description |
| --- | --- |
| [Realm/Jazzy](https://github.com/realm/jazzy) | Soulful docs for Swift & Objective-C. Framework used to generate documentation of the code. |
| App icon and buttons | https://www.flaticon.com & https://makeappicon.com/ |
| [Realm database migrations](https://realm.io/docs/swift/latest/#migrations) | The procedure we need to follow in case the Realm database model changes. |

## 3. Future work & Improvements
Among other things:
- Include an animation when the app is launching.
- Extend the model of the app with more useful information for the user.
- ...

## 4. Feedback
As I am continuously learning, I would appreciate if you take a look at my code and you have recommendations to improve it in different ways. You can contact me at rodri.lopezromero@gmail.com to do so :smiley:

## License
The contents of this repository are covered under the [Apache License 2.0](https://choosealicense.com/licenses/apache-2.0/).
