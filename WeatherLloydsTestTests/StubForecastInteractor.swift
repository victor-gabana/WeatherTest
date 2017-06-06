//
//  StubForecastInteractor.swift
//  WeatherLloydsTest
//
//  Created by Divide by Zero on 06/06/2017.
//  Copyright © 2017 Divide by Zero. All rights reserved.
//

import Foundation
import WeatherLloydsTest

class StubForecastInteractor: ForecastInteractorProtocol {
    
    public var mockCityForecast: CityForecast?
    
    var weatherService: WeatherServiceProtocol
    
    required init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
    }
    
    func fetchForecastModel(completion: ((CityForecast) -> Void)?) {
        if let mockCityForecast = mockCityForecast {
            completion?(mockCityForecast)
        }
    }
}
