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

        let forecastPresenter = ForecastPresenter()
        forecastPresenter.fetchForecastViewModel { (cityForecastViewModel, dayForecastViewModels) in
            self.populateCityView(withViewModel: cityForecastViewModel)
            
            let nowForecast = dayForecastViewModels.first
            if let nowForecast = nowForecast {
                self.populateNowForecastView(withViewModel: nowForecast)
            }
            
            guard dayForecastViewModels.count >= 5 else {
                return
            }
            self.loadDayForecastSubViews(dayForecastViewModels: [dayForecastViewModels[1], dayForecastViewModels[2], dayForecastViewModels[3], dayForecastViewModels[4]])
        }
    }
    
    //MARK: Private
    
    private func populateCityView(withViewModel cityForecastViewModel: CityForecastViewModel) {
        self.cityAndCountryLabel.text = cityForecastViewModel.cityAndCountry
    }
    
    private func populateNowForecastView(withViewModel dayForecastViewModel: DayForecastViewModel) {
        self.weekDayLabel.text = dayForecastViewModel.weekDay
        self.tempLabel.text = dayForecastViewModel.temp
        self.maxTempLabel.text = dayForecastViewModel.maxTemp
        self.minTempLabel.text = dayForecastViewModel.minTemp
        self.weatherImage.image = dayForecastViewModel.icon
        self.humidityLabel.text = dayForecastViewModel.humidity
    }
    
    
    private func loadDayForecastSubViews(dayForecastViewModels: Array<DayForecastViewModel>) {
        
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
            
            weekDayView.populateView(withViewModel: dayForecastViewModels[index])
            
        }
        
        self.loadViewIfNeeded()
    }
}

