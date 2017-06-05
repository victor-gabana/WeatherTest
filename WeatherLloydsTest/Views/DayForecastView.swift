//
//  DayForecastView.swift
//  WeatherLloydsTest
//
//  Created by Divide by Zero on 04/06/2017.
//  Copyright © 2017 Divide by Zero. All rights reserved.
//

import Foundation
import UIKit

public class DayForecastView: UIView {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    // Ideally we would use all the properties of the model to populate the view. Due lack of time Im just using weekDay and Icon
    public func populateView(withViewModel dayForecastViewModel: DayForecastViewModel) {
        self.name.text = dayForecastViewModel.weekDay
        self.weatherImage.image = dayForecastViewModel.icon
    }
}
