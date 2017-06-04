//
//  NetworkManager.swift
//  WeatherLloydsTest
//
//  Created by Divide by Zero on 04/06/2017.
//  Copyright © 2017 Divide by Zero. All rights reserved.
//

import Foundation

class NetworkingManager {
    
    // TODO: Inject from outisde the following params
    let session = URLSession.shared
    // parser
    
    public func requestJSON(url: URL, completion: ((NetworkResponse<Any>) -> Void)? = nil) {
        
        
        self.request(url: url) { (response) in
            switch response {
            case .error(let error):
                completion?(.error(error))
            case .success(let data, let urlResponse):
                
                guard let contentType = urlResponse.allHeaderFields["Content-Type"] as? String , contentType.contains("application/json") else {
                    completion?(.error(NetworkError.invalidHTTPResponseContentType))
                    return
                }
                
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
                    completion?(.error(NetworkError.invalidResponseFormat))
                    return
                }
                
                completion?(.success(json))
            }
        }
    }
    
    
    private func request(url: URL, completion: ((NetworkResponse<(data: Data, urlResponse: HTTPURLResponse)>) -> Void)? = nil) {
        
        let task = session.dataTask(with: url) { (data, urlResponse, error) in
            if let error = error {
                completion?(.error(error))
                return
            } else {
                
                guard let urlResponse = urlResponse as? HTTPURLResponse else {
                    completion?(.error(NetworkError.invalidHTTPResponse))
                    return
                }
                
                guard let data = data else {
                    completion?(.error(NetworkError.noData))
                    return
                }
                
                guard data.count > 0 else {
                    completion?(.error(NetworkError.emptyData))
                    return
                }
                
                guard urlResponse.statusCode == 200 else {
                    completion?(.error(NetworkError.invalidHTTPResponseStatusCode))
                    return
                }
                
                completion?(.success((data, urlResponse)))
            }
        }
        task.resume()
    }
    
}