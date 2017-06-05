//
//  ForecastInteractor.swift
//  WeatherLloydsTest
//
//  Created by Divide by Zero on 05/06/2017.
//  Copyright © 2017 Divide by Zero. All rights reserved.
//

import Foundation

class ForecastInteractor {
    
    let weatherService = WeatherService()
    
    let cityId = "2648110" // London
    
    public func fetchForecastModel(completion: ((CityForecast) -> Void)? = nil) {
        
        self.weatherService.fetchCityForecast(forCityId: cityId) { (cityForecast) in
            
            let newWeekForecast = self.oneForecastPerWeekDay(allForecasts: cityForecast.weekForecast)
            
            let newCityForecast = CityForecast(cityName: cityForecast.cityName, countryName: cityForecast.countryName, weekForecast: newWeekForecast)
            
            completion?(newCityForecast)
        }
    }
    
    private func oneForecastPerWeekDay(allForecasts: [DayForecast]) -> [DayForecast] {
    
        var currentDay = Date()
        var newWeekForecast = Array<DayForecast>()
        
        for dayForecast in allForecasts {
            if dayForecast.date.weekDay() == currentDay.weekDay() {
                newWeekForecast.append(dayForecast)
                // Moving into the next day of the week
                currentDay = Calendar.current.date(byAdding: .day, value: 1, to: currentDay)!
            }
        }

        return newWeekForecast
    }
}
