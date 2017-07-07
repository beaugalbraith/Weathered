//
//  WeatherService.swift
//  weathered
//
//  Created by Beau Galbraith on 6/26/17.
//  Copyright © 2017 Beau Galbraith. All rights reserved.
//

import Foundation
import Alamofire

class WeatherService {
    static let instance = WeatherService()
    fileprivate var _currentWeather = CurrentWeather()
    fileprivate var _forecast = [Forecast]()
    
    var currentWeather: CurrentWeather {
        get {
            return _currentWeather
        }
        set {
            _currentWeather = newValue
        }
    }
    
    var forecast: [Forecast] {
        get {
            return _forecast
            
        } set {
            _forecast = newValue
        }
    }
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        let url = URL(string: API_URL_CURRENT_WEATHER)

        Alamofire.request(url!).responseData{(response) in
            self.currentWeather = CurrentWeather.loadCurrentWeather(from: response.data!)
//            print(self.currentWeather.cityName)
//            print(self.currentWeather.currentTemp)
//            print(self.currentWeather.date)
//            print(self.currentWeather.weatherType)
            completed()

        }
    }
    func downloadForecast(completed: @escaping DownloadComplete) {
        let url = URL(string: API_URL_FORECAST)
        Alamofire.request(url!).responseData { (response) in
            self.forecast = Forecast.loadForecast(from: response.data!)
            if self.forecast.count > 0 {
                self.forecast.remove(at: 0)
            }
            completed()
        }
    }
}
