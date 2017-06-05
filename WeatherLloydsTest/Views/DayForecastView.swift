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
    
    public func populateView(weekDayName: String?, weatherImage:UIImage?) {
        self.name.text = weekDayName
        self.weatherImage.image = weatherImage
    }
}
