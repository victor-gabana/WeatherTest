//
//  WeatherService.swift
//  WeatherLloydsTest
//
//  Created by Divide by Zero on 04/06/2017.
//  Copyright © 2017 Divide by Zero. All rights reserved.
//

import Foundation

class WeatherService {
    
    // Url format: "http://api.openweathermap.org/data/2.5/forecast?id=2648110&APPID=eeef68ba9ea2c135341c00d4fd11281b"
    let baseUrl = "http://api.openweathermap.org/"
    let urlPath = "data/2.5/forecast"
    let apiId = "eeef68ba9ea2c135341c00d4fd11281b"
    
    // TODO: Inject from outisde the following params
    let networkinManager = NetworkingManager()
    
    public func fetchCityForecast(forCityId cityId: String, completion: ((CityForecast) -> Void)? = nil) {
        
        let parameters = ["id" : cityId, "APPID" : apiId]
        let urlString = self.formUrlString(path: urlPath, parameters: parameters)
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        self.networkinManager.requestJSON(url: url) { (networkResponse) in
            switch networkResponse {
            case .success(let json):
                let modelParser = ModelParser()
                let cityForecast = modelParser.parseCityForecast(json: json as! Dictionary<String, Any>)
                
                DispatchQueue.main.async {
                    completion?(cityForecast)
                }
                
            case .error(let error):
                print("error: ", error)
            }
        }
    }
    
    private func formUrlString(path:String, parameters:Dictionary<String, String>?) -> String {
        
        var urlString = baseUrl + urlPath
        
        if let parameters = parameters {
            let parameterString = (parameters.flatMap({ (key, value) -> String in
                return "\(key)=\(value)"
            }) as Array).joined(separator: "&")
            
            if parameterString.characters.count > 0 {
                urlString += "?" + parameterString
            }
        }
        
        return urlString
    }
    
}
