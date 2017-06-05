//
//  ForecastPresenter.swift
//  WeatherLloydsTest
//
//  Created by Divide by Zero on 05/06/2017.
//  Copyright © 2017 Divide by Zero. All rights reserved.
//

import Foundation
import UIKit

public protocol ForecastPresenterProtocol {
    init(interactor: ForecastInteractorProtocol)
    func fetchForecastViewModel(completion: ((CityForecastViewModel, [DayForecastViewModel]) -> Void)?)
}


class ForecastPresenter: ForecastPresenterProtocol {
    
    let interactor: ForecastInteractorProtocol
    
    required init(interactor: ForecastInteractorProtocol) {
        self.interactor = interactor
    }
    
    func fetchForecastViewModel(completion: ((CityForecastViewModel, [DayForecastViewModel]) -> Void)? = nil) {
        
        self.interactor.fetchForecastModel { (cityForecast) in
            let cityForecastViewModel = self.cityForecastViewModel(cityForecast: cityForecast)
            
            var dayForecastsViewModels = Array<DayForecastViewModel>()
            for dayForecast in cityForecast.weekForecast {
                dayForecastsViewModels.append(self.dayForecastViewModel(dayForecast: dayForecast))
            }
            
            completion?(cityForecastViewModel, dayForecastsViewModels)
        }
    }
    
    //MARK: Private
    
    private func cityForecastViewModel(cityForecast: CityForecast) -> CityForecastViewModel  {
        return CityForecastViewModel(cityAndCountry: cityForecast.cityName + ", " + cityForecast.countryName)
    }
    
    private func dayForecastViewModel(dayForecast: DayForecast) -> DayForecastViewModel  {
        
        let weekDay = dayForecast.date.weekDay() ?? ""
        let tempString = self.tempToString(tempFloat: dayForecast.temp)
        let maxTempString = tempToString(tempFloat: dayForecast.maxTemp)
        let minTempString = tempToString(tempFloat: dayForecast.minTemp)
        // Removing the server "n" or "m" characters at the end of the icon name.
        let imageName = String(dayForecast.icon.characters.dropLast(1))
        let weatherImage = UIImage(named: imageName)
        let humidityString = String(format: "%i%%", dayForecast.humidity)
        
        return DayForecastViewModel(temp: tempString, maxTemp: maxTempString, minTemp: minTempString, humidity: humidityString, weekDay: weekDay, icon: weatherImage)
    }
    
    private func tempToString(tempFloat: Float) -> String {
        return String(format: "%.2f°", tempFloat)
    }
    
    
}
