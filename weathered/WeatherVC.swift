//
//  WeatherVC.swift
//  weathered
//
//  Created by Beau Galbraith on 6/25/17.
//  Copyright © 2017 Beau Galbraith. All rights reserved.
//

import Cocoa
import Alamofire

class WeatherVC: NSViewController {
    @IBOutlet weak var dateLabel: NSTextField!
    @IBOutlet weak var temperatureLabel: NSTextField!

    @IBOutlet weak var locationLabel: NSTextField!
    @IBOutlet weak var weatherImageIcon: NSImageView!
    @IBOutlet weak var weatherStatusLabel: NSTextField!
    
    @IBOutlet weak var collectionView: NSCollectionView!
    
    @IBOutlet weak var openWeatherMapButton: NSButton!
    @IBOutlet weak var quitButton: NSButton!
    @IBAction func openWeatherButtonPushed(_ sender: NSButton) {
        let url = URL(string: "http://openweathermap.org")
        NSWorkspace.shared().open(url!)
    }
    @IBAction func quitButtonPushed(_ sender: NSButton) {
        NSApplication.shared().terminate(nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    override func viewWillAppear() {
        NotificationCenter.default.addObserver(self, selector: #selector(WeatherVC.dataDownloadNotification(_:)), name: COMPLETE_NOTIFICATION, object: nil)
    }
    override func viewDidAppear() {

        
        self.view.layer?.backgroundColor = CGColor(red: 0.29, green: 0.72, blue: 0.98, alpha: 1.0)
        updateUi()
        quitButton.styleButtonText(button: quitButton, buttonName: "Quit", fontColor: .darkGray, alignment: .center, font: "Avenir Next", size: 11)
        openWeatherMapButton.styleButtonText(button: openWeatherMapButton, buttonName: "OpenWeatherMap", fontColor: .darkGray, alignment: .center, font: "Avenir Next", size: 11)
        
    }
    func dataDownloadNotification(_ notif: Notification) {
        updateUi()
        print("Updateded UI Notification")
    }
    func updateUi(){
        let weather = WeatherService.instance.currentWeather
        dateLabel.stringValue = weather.date
        temperatureLabel.stringValue = "\(weather.currentTemp)°"
        locationLabel.stringValue = weather.cityName
        weatherStatusLabel.stringValue = weather.weatherType
        weatherImageIcon.image = NSImage(named: weather.weatherType)
        collectionView.reloadData()
    }
    
    override func viewWillDisappear() {
        NotificationCenter.default.removeObserver(self, name: COMPLETE_NOTIFICATION, object: nil)
    }
}

extension WeatherVC: NSCollectionViewDelegate, NSCollectionViewDataSource, NSCollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let forecastItem = collectionView.makeItem(withIdentifier: "WeatherCell", for: indexPath)
        guard let forecastCell = forecastItem as? WeatherCell else { return forecastItem }
        forecastCell.configureCell(weatherCell: WeatherService.instance.forecast[indexPath.item])
        return forecastItem
    }
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return WeatherService.instance.forecast.count
    }
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return NSSize(width: 125, height: 125)
    }
}
