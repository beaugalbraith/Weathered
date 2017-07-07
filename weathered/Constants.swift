//
//  Constants.swift
//  weathered
//
//  Created by Beau Galbraith on 6/26/17.
//  Copyright © 2017 Beau Galbraith. All rights reserved.
//

import Foundation
typealias DownloadComplete = () -> ()
let LATITUDE = Location.instance.latitude
let LONGITUDE = Location.instance.longitude

let API_KEY = "&appid=5aa6d844adf72e024dff9387d78b24b5"
let API_UNITS = "&units=imperial"
let API_URL_CURRENT_WEATHER = "http://api.openweathermap.org/data/2.5/weather?lat=\(LATITUDE)&lon=\(LONGITUDE)\(API_UNITS)\(API_KEY)"
let API_URL_FORECAST = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(LATITUDE)&lon=\(LONGITUDE)&cnt=8\(API_UNITS)\(API_KEY)"
let COMPLETE_NOTIFICATION = NSNotification.Name("dataDownloaded")
