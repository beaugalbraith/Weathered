//
//  CurrentWeather.swift
//  weathered
//
//  Created by Beau Galbraith on 6/26/17.
//  Copyright © 2017 Beau Galbraith. All rights reserved.
//

import Foundation
import SwiftyJSON

class CurrentWeather {
    fileprivate var _cityName: String!
    fileprivate var _date: String!
    fileprivate var _weatherType: String!
    fileprivate var _currentTemp: Int!
    
    var cityName: String {
        get {
            return _cityName
        }
        set {
            _cityName = newValue
        }
    }
    var date: String {
        get {
            return _date
        }
        set {
            _date = newValue
        }
    }
    var weatherType: String {
        get {
            return _weatherType
        }
        set {
            _weatherType = newValue
        }
    }
    var currentTemp: Int {
        get {
                return _currentTemp
        }
        set {
            _currentTemp = newValue
        }
    }
    
    class func loadCurrentWeather(from: Data) -> CurrentWeather {
        let currentWeather = CurrentWeather()
        let swiftyJson = JSON(data: from)
        
        currentWeather.cityName = swiftyJson["name"].stringValue.capitalized
        currentWeather.weatherType = swiftyJson["weather"][0]["main"].stringValue.capitalized
        currentWeather.currentTemp = swiftyJson["main"]["temp"].intValue
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from: Date())
        currentWeather.date = "Today, \(currentDate)"
        
        return currentWeather
    }

}
