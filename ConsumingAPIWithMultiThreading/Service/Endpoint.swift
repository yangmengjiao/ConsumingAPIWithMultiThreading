//
//  Endpoint.swift
//  20201215-MengjiaoYang-NYCSchools
//
//  Created by mengjiao on 12/16/20.
//

import Foundation

protocol Endpoint {
    // "HTTP or HTTPS"
    var scheme: String { get }
    
    // Example: "api.covidtracking.com"
    var baseURL: String { get }
    
    // Example: "/v1/states/daily.json"
    var path: String { get }
    
    // [URLQueryItem(name: "api_key", value: "6436536232")]
    var parameters: [URLQueryItem] { get }
    
    // Example: "GET"
    var method: String { get }
}
