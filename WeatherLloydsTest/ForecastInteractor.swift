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
            completion?(cityForecast)
        }
    }
}
