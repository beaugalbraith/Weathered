//
//  WeatherCell.swift
//  weathered
//
//  Created by Beau Galbraith on 6/25/17.
//  Copyright © 2017 Beau Galbraith. All rights reserved.
//

import Cocoa

class WeatherCell: NSCollectionViewItem {

    @IBOutlet weak var lowTemperature: NSTextField!
    @IBOutlet weak var highTemperature: NSTextField!
    @IBOutlet weak var weatherCellImage: NSImageView!
    @IBOutlet weak var cellDate: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = CGColor(red: 0.69, green: 0.85, blue: 0.99, alpha: 0.5)
        self.view.layer?.cornerRadius = 5
    }
    func configureCell(weatherCell: Forecast) {
        weatherCellImage.image = NSImage(named: weatherCell.weatherType)
        highTemperature.stringValue = "\(weatherCell.highTemp)°"
        lowTemperature.stringValue = "\(weatherCell.lowTemp)°"
        cellDate.stringValue = weatherCell.date
    }
}
