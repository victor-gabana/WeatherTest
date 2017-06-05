//
//  ViewController.swift
//  WeatherLloydsTest
//
//  Created by Divide by Zero on 04/06/2017.
//  Copyright © 2017 Divide by Zero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityAndCountryLabel: UILabel!
    
    @IBOutlet weak var weekDayLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var weatherImage: UIImageView!
    
    @IBOutlet weak var maxTempLabel: UILabel!
    
    @IBOutlet weak var minTempLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var firstWeekDayContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let weatherService = WeatherService()
        weatherService.fetchForecast(forCityId: "2648110")
        
        // Dummy data///////////////
        let dummyDayForecast = DayForecast(id: "1", main: "Sunny", description: "Very sunny", temp: 24.0, maxTemp: 27.0, minTemp: 20.0, humidity: 65, date: Date(), icon: "02n")
        let dummyCityForecast = CityForecast(cityName: "London", countryName: "UK", weekForecast: [dummyDayForecast,dummyDayForecast,dummyDayForecast,dummyDayForecast,dummyDayForecast])
        ////////////////////////////
        
        self.cityAndCountryLabel.text = dummyCityForecast.cityName + ", " + dummyCityForecast.countryName
        
        let nowForecast = dummyCityForecast.weekForecast.first
        if let nowForecast = nowForecast {
            self.weekDayLabel.text = nowForecast.weekDay
            self.tempLabel.text = nowForecast.tempString
            self.maxTempLabel.text = nowForecast.maxTempString
            self.minTempLabel.text = nowForecast.minTempString
            self.weatherImage.image = nowForecast.weatherImage
            self.humidityLabel.text = nowForecast.humidityString
        }
        
        // Add other 4 week days views
        
        
        
    
        let firstWeekDayView = UINib(nibName: "DayForecastView", bundle: nil).instantiate(withOwner: self, options: nil).first as! DayForecastView
        
        firstWeekDayView.translatesAutoresizingMaskIntoConstraints = false
        self.firstWeekDayContainerView.addSubview(firstWeekDayView)

        let views = ["firstWeekDayView": firstWeekDayView]
        var constraints = [NSLayoutConstraint]()
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[firstWeekDayView]|", options: [], metrics: nil, views:views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[firstWeekDayView]|", options: [], metrics: nil, views:views)
        NSLayoutConstraint.activate(constraints)
        
        let forecast = dummyCityForecast.weekForecast[2]
        firstWeekDayView.populateView(weekDayName: forecast.weekDay!, weatherImage: forecast.weatherImage)
    }

}

