//
//  NSDate.swift
//  weathered
//
//  Created by Beau Galbraith on 6/26/17.
//  Copyright © 2017 Beau Galbraith. All rights reserved.
//

import Foundation
extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: self)
    }
}
