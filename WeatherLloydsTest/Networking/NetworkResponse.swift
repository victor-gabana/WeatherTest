//
//  NetworkResponse.swift
//  WeatherLloydsTest
//
//  Created by Divide by Zero on 04/06/2017.
//  Copyright © 2017 Divide by Zero. All rights reserved.
//

import Foundation

public enum NetworkResponse<T> {
    case success(T)
    case error(Error)
}
