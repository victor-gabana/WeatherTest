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
    
    @IBOutlet weak var secondWeekDayContainerView: UIView!
    
    @IBOutlet weak var thirdWeekDayContainerView: UIView!
  
    @IBOutlet weak var fourthWeekDayContainerView: UIView!
    
    
    var firstWeekDayView: DayForecastView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let weatherService = WeatherService()
        weatherService.fetchCityForecast(forCityId: "2648110") { (cityForecast) in
            self.cityAndCountryLabel.text = cityForecast.cityName + ", " + cityForecast.countryName
            
            let nowForecast = cityForecast.weekForecast.first
            if let nowForecast = nowForecast {
                self.weekDayLabel.text = nowForecast.weekDay
                self.tempLabel.text = nowForecast.tempString
                self.maxTempLabel.text = nowForecast.maxTempString
                self.minTempLabel.text = nowForecast.minTempString
                self.weatherImage.image = nowForecast.weatherImage
                self.humidityLabel.text = nowForecast.humidityString
            }
        
            self.loadDayForecastSubViews(daysForecast: [cityForecast.weekForecast[1], cityForecast.weekForecast[2], cityForecast.weekForecast[3], cityForecast.weekForecast[4]])
        }
    }
    
    private func loadDayForecastSubViews(daysForecast: Array<DayForecast>) {
        
        let containerViews = [self.firstWeekDayContainerView, self.secondWeekDayContainerView, self.thirdWeekDayContainerView, self.fourthWeekDayContainerView]
        

        for (index, containerView) in containerViews.enumerated() {
        
            let weekDayView = UINib(nibName: "DayForecastView", bundle: nil).instantiate(withOwner: self, options: nil).first as! DayForecastView
            
            weekDayView.translatesAutoresizingMaskIntoConstraints = false
            containerView?.addSubview(weekDayView)
            
            let views = ["weekDayView": weekDayView]
            var constraints = [NSLayoutConstraint]()
            constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[weekDayView]|", options: [], metrics: nil, views:views)
            constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[weekDayView]|", options: [], metrics: nil, views:views)
            NSLayoutConstraint.activate(constraints)
            
            weekDayView.populateView(weekDayName: daysForecast[index].weekDay!, weatherImage:daysForecast[index].weatherImage)
            
        }
        
        self.loadViewIfNeeded()
    }
}

