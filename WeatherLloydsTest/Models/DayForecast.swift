//
//  DayForecast.swift
//  WeatherLloydsTest
//
//  Created by Divide by Zero on 04/06/2017.
//  Copyright © 2017 Divide by Zero. All rights reserved.
//

import Foundation

public struct DayForecast {
//    let id: String
//    let main: String
//    let description: String
    let temp: Float
    let maxTemp: Float
    let minTemp: Float
    let humidity: Int
    let date: Date
    let icon: String
    
    var weekDay: String? {
        get {
            return date.weekDay()
        }
    }
}

