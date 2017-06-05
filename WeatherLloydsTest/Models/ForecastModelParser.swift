//
//  ForecastModelParser.swift
//  WeatherLloydsTest
//
//  Created by Divide by Zero on 05/06/2017.
//  Copyright © 2017 Divide by Zero. All rights reserved.
//

import Foundation

public protocol ForecastModelParserProtocol {
    func parseCityForecast(json: Dictionary<String, Any>) -> CityForecast
}

class ForecastModelParser: ForecastModelParserProtocol {
    
    func parseCityForecast(json: Dictionary<String, Any>) -> CityForecast {
        
        let cityDict = json["city"] as! Dictionary<String, Any>
        let cityName = cityDict["name"] as! String
        let countryName = cityDict["country"] as! String
        
        var weekForecast = Array<DayForecast>()
        let list = json["list"] as! Array<Any>

        for dayForecastDictionary in list {
            let dayForecast = self.parseDayForecast(json: dayForecastDictionary as! Dictionary<String, Any>)
            weekForecast.append(dayForecast)
        }
        let cityForecast = CityForecast(cityName: cityName, countryName: countryName, weekForecast: weekForecast)
    
        return cityForecast
    }
    
    func parseDayForecast(json: Dictionary<String, Any>) -> DayForecast {
        
        let main: Dictionary<String, Any> = json["main"]  as! Dictionary<String, Any>
        let temp = main["temp"] as! Float
        let maxTemp = main["temp_max"] as! Float
        let minTemp = main["temp_min"] as! Float
        let humidity = main["humidity"] as! Int
        let date = Date(timeIntervalSince1970: json["dt"] as! TimeInterval)
        let weatherArray = json["weather"]  as! Array<Any>
        let weather = weatherArray.first as! Dictionary<String, Any>
        let icon = weather["icon"] as! String
        
        let dayForecast = DayForecast(temp: temp, maxTemp: maxTemp, minTemp: minTemp, humidity: humidity, date: date, icon: icon)
        
        return dayForecast
    }

}
