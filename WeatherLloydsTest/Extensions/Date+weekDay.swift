//
//  Date+weekDay.swift
//  WeatherLloydsTest
//
//  Created by Divide by Zero on 05/06/2017.
//  Copyright © 2017 Divide by Zero. All rights reserved.
//

import Foundation

extension Date {
    func weekDay() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        
        return dateFormatter.string(from: self).capitalized
    }
}
