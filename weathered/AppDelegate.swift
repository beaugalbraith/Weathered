//
//  AppDelegate.swift
//  weathered
//
//  Created by Beau Galbraith on 6/25/17.
//  Copyright © 2017 Beau Galbraith. All rights reserved.
//

import Cocoa
import CoreLocation

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, CLLocationManagerDelegate {


    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        print("application did finish launching")
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 1000
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.startUpdatingLocation()
        print("started updating location")
        let updateTimer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(AppDelegate.downloadWeatherData), userInfo: nil, repeats: true)
        
        updateTimer.tolerance = 60
        statusItem.button?.title = "--°"
        statusItem.action = #selector(AppDelegate.displayPopUp(_:))

    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations[locations.count - 1]
        Location.instance.latitude = currentLocation.coordinate.latitude
        Location.instance.longitude = currentLocation.coordinate.longitude
        downloadWeatherData()
    }
    func downloadWeatherData() {

        print("got here")
        WeatherService.instance.downloadWeatherDetails {
            self.statusItem.button?.title = "\(WeatherService.instance.currentWeather.currentTemp)°"
            WeatherService.instance.downloadForecast {
                NotificationCenter.default.post(name: NSNotification.Name("dataDownloaded"), object: nil)
                self.locationManager.stopUpdatingLocation()
            }
        }

    }
    func displayPopUp(_ sender: AnyObject?) {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateController(withIdentifier: "WeatherVC") as? NSViewController else { return }
        let popOver = NSPopover()
        popOver.contentViewController = vc
        popOver.behavior = .transient
        popOver.show(relativeTo: statusItem.button!.bounds, of: statusItem.button!, preferredEdge: .minY)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

