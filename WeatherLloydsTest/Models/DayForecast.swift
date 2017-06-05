//
//  DayForecast.swift
//  WeatherLloydsTest
//
//  Created by Divide by Zero on 04/06/2017.
//  Copyright © 2017 Divide by Zero. All rights reserved.
//

import Foundation
import UIKit // TODO remove this once refactored

public struct DayForecast {
    let id: String
    let main: String
    let description: String
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
    var tempString: String {
        get {
            return tempToString(tempFloat: temp)
        }
    }
    var maxTempString: String {
        get {
            return tempToString(tempFloat: maxTemp)
        }
    }
    var minTempString: String {
        get {
            return tempToString(tempFloat: minTemp)
        }
    }
    var weatherImage: UIImage? {
        get {
            // Removing the server "n" or "m" characters at the end of the icon name.
            let imageName = String(icon.characters.dropLast(1))
            
            return UIImage(named: imageName)
        }
    }
    var humidityString: String {
        return String(format: "%i%%", humidity)
    }
    
    
    private func tempToString(tempFloat: Float) -> String {
        return String(format: "%.2f°", tempFloat)
    }
    
}

