//
//  ViewController.swift
//  WeatherLloydsTest
//
//  Created by Divide by Zero on 04/06/2017.
//  Copyright © 2017 Divide by Zero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let weatherService = WeatherService()
        weatherService.fetchForecast(forCityId: "2648110")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

